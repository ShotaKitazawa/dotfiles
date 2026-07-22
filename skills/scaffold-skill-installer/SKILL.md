---
name: scaffold-skill-installer
description: 任意のリポジトリに「skills/ ディレクトリ + install-skills.sh」の配布パターンを新規セットアップする。ユーザーが「このリポジトリにも skill installer を作って」「skill を配布できるようにして」のように言ったときに使う。Claude Code (~/.claude/skills) と Codex (~/.codex/skills) の両方に、user/project/target スコープでインストールできるようにする。
---

# scaffold-skill-installer

リポジトリ内の `skills/<skill名>/SKILL.md` 群を、Claude Code / Codex CLI が読み込める場所
(`~/.claude/skills`, `~/.codex/skills` など)へインストールするスクリプトを新規に設置する。

インストーラーは **スクリプト自身のパスを基準に** `skills/` を解決する(cwd 基準にしない)。
`"$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"` でスクリプト自身の位置から一つ上のディレクトリを取り、
そこにある `skills/` を対象にする。これにより、リポジトリ直下で直接実行する場合はもちろん、
chezmoi のように `chezmoi.sourceDir` など任意の場所からフルパスで呼び出される場合でも
cwd に依存せず正しく動く。

## 適用対象の判断基準

このパターンは「skill 配布専用のリポジトリ(dotfiles など)」に限らない。**あるアプリケーション
リポジトリに、そのリポジトリ自身のコード/ツール(例: 自前の MCP サーバーやAPI)を操作するための
skill を1本だけ追加したい場合も、正当な適用対象である。** ソースコードと、それを操作する skill が
同じリポジトリにあるのは自然な設計であり、「配布先が複数(Codex/Claude, user/project)ある」こと
自体がこのパターンを使う条件であって、「そのリポジトリの主目的が skill 配布であること」は条件では
ない。

判断を誤りやすい点: 「このリポジトリは skill 配布が主目的ではないから、`.claude/skills/<name>/SKILL.md`
を直接置けば十分で `skills/` + `install-skills.sh` は過剰」と早合点しないこと。単一skillであっても、
「そのプロジェクトで作業するときに使う(`--project`)」と「他のプロジェクトでも使い回す・Codexからも
使う(`--user`)」の両方を選択肢として残したいなら、`skills/` を正としてそこから両方の場所へ配布する
この構成の方が適切である。`.claude/skills/<name>` に直接書くのは、他ツール・他スコープへの配布が
明確に不要な場合の簡易版として選ぶべきもの。

## 手順

1. **配置場所を決める**
   - スクリプト本体は `scripts/install-skills.sh` と `.scripts/install-skills.sh` のどちらか、
     既存リポジトリの慣習(既に `scripts/` か `.scripts/` があるか)に合わせる。無ければ `scripts/install-skills.sh` を既定にする。
   - `skills/` はリポジトリ直下。無ければ作成する(中身が空でもよい。ユーザーが後で `skills/<name>/SKILL.md` を追加する前提)。

2. **chezmoi 管理下かどうかを確認する**
   - リポジトリ直下に `.chezmoiroot` や `dot_*` / `run_once_*` 命名のファイルがあれば chezmoi 管理。
   - 該当する場合のみ、後述の `run_onchange_after_install-skills.sh.tmpl` も追加する。判断に迷ったらユーザーに確認する。

3. **`install-skills.sh` を作成する**(下記テンプレートをそのまま設置。`chmod +x` を忘れずに)

   ```bash
   #!/usr/bin/env bash
   set -euo pipefail

   scope="user"
   target_dir=""

   print_usage() {
     cat <<USAGE
   Usage: $0 [--user|--project|--target DIR]
     --user           Install to ~/.claude/skills and ~/.codex/skills (default)
     --project        Install to ./.claude/skills and ./.codex/skills (current dir)
     --target DIR     Install to DIR/.claude/skills and DIR/.codex/skills
   USAGE
   }

   while [ $# -gt 0 ]; do
     case "$1" in
       -u|--user)    scope="user"; shift ;;
       -p|--project) scope="project"; shift ;;
       -t|--target)  scope="target"; target_dir="${2:-}"; shift 2 ;;
       -h|--help)    print_usage; exit 0 ;;
       *) echo "Unknown option: $1" >&2; print_usage >&2; exit 1 ;;
     esac
   done

   case "$scope" in
     user)    base="$HOME" ;;
     project) base="$PWD" ;;
     target)
       [ -n "$target_dir" ] || { echo "--target requires a directory" >&2; exit 1; }
       base="$(cd "$target_dir" && pwd)"
       ;;
   esac

   # スクリプト自身の位置から skills/ を解決する(cwd に依存しない)。
   # レポジトリ直下に置くなら "/.." の階層数を実際のパスに合わせて調整すること。
   script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

   codex_root="$base/.codex/skills"
   claude_root="$base/.claude/skills"

   echo "Installing skills into:"
   echo "  $codex_root"
   echo "  $claude_root"

   for dest_root in "$codex_root" "$claude_root"; do
     mkdir -p "$dest_root"
     for d in "$script_dir"/skills/*; do
       [ -d "$d" ] || continue
       dest="$dest_root/$(basename "$d")"

       if [ "$dest_root" = "$claude_root" ]; then
         # Claude skill loader doesn't treat symlinks as directories.
         [ ! -L "$dest" ] || rm "$dest"
         [ ! -e "$dest" ] || rm -rf "$dest"
         cp -R "$d" "$dest"
       else
         [ ! -L "$dest" ] || rm "$dest"
         [ ! -e "$dest" ] || rm -rf "$dest"
         ln -s "$d" "$dest"
       fi
     done
   done
   ```

   - `script_dir` の `/..`  は「スクリプトを `scripts/install-skills.sh` に置く」前提。`.scripts/install-skills.sh` でも同じ階層(1つ上がリポジトリ直下)なのでそのままでよい。

4. **(chezmoi 管理下の場合のみ)自動反映フックを追加する**

   `run_onchange_after_install-skills.sh.tmpl` を作成する:

   ```
   #!/usr/bin/env bash
   set -euo pipefail

   # Re-run only when a file under skills/ changes.
   # skills hash: {{ output "sh" "-c" "find \"$1\" -type f | sort | xargs shasum -a 256 | shasum -a 256" "--" (joinPath .chezmoi.sourceDir "skills") | trim }}

   "{{ .chezmoi.sourceDir }}/.scripts/install-skills.sh"
   ```

   - `run_onchange_` prefix + テンプレート内のハッシュコメントが、`skills/` 配下のファイルが変わったときだけ `chezmoi apply` 時に再実行させる仕組み。
   - パスの `.scripts/install-skills.sh` は手順1で決めた実際の配置パスに置き換える。

5. **後片付けと報告**
   - `chmod +x` を新規スクリプトに付与する。
   - chezmoi 管理下でない場合、README 等に実行方法(`./scripts/install-skills.sh` or `./scripts/install-skills.sh --project`)を一言添えるとよい(必須ではない、ユーザーの希望があれば)。
   - **`install-skills.sh` の実行(＝ `~/.claude/skills` 等への書き込み)は必ずユーザーに確認してから行う**。同名の既存 skill を上書きする可能性があるため。

## 注意点

- `skills/` が空でも動くようにスクリプトを書くこと(`for d in .../skills/*; do [ -d "$d" ] || continue; ...`)。空ディレクトリで作成直後に壊れないことを確認する。
