---
name: herdr-gaps
description: herdr の機能ギャップ一覧(private gist)を棚卸しする。上流 ogulcancelik/herdr の実装状況を照会し、解決済み項目を Resolved へ移動して gist を更新する。引数 `add <text>` で新しいギャップを追記。herdr の足りない機能・不満点の管理はすべてこの skill 経由で行う。
---

# herdr-gaps

herdr に足りてない機能の一覧を管理する。データは private gist(write-many メモ)、この skill は棚卸しロジックのみ。

- Gist ID: `cd60ae40193d7340ca534812a3565162`(https://gist.github.com/ShotaKitazawa/cd60ae40193d7340ca534812a3565162 、ファイル名 `herdr-gaps.md`)
- gist の構成はデータのみ: `## 検査状況`(検査済みバージョン)/ `## Gaps` / `## Resolved` / `## 検査履歴`。運用ルールの説明は gist に書かず、この skill に集約する
- 一覧には「純粋な機能ギャップ」だけを書く。バンプ・コミット・報告などの作業 TODO は書かない(作業はその都度の会話で扱う)。ユーザーは任意の端末から Web / `gh gist edit` で直接追記することがある
- **gh コマンドは必ず `GH_HOST=github.com` を明示する**(GHES がデフォルトの端末でも gist / 上流照会が github.com に向くように)

gist には `## 検査状況`(どのバージョンのリリース内容まで一覧に反映済みか)と `## 検査履歴` があり、この skill が維持する。**検査済みバージョンより新しいリリースが上流にないときは項目ごとの照会をスキップする**(余計な検索をしないため)。

## 手順(引数なし = 棚卸し)

1. 一覧を取得する:
   ```sh
   GH_HOST=github.com gh api gists/cd60ae40193d7340ca534812a3565162 --jq '.files["herdr-gaps.md"].content'
   ```
2. `## 検査状況` の検査済みバージョンと上流の最新リリースを比較する:
   ```sh
   GH_HOST=github.com gh release list --repo ogulcancelik/herdr --limit 1
   ```
   - **最新リリース ≤ 検査済みバージョンなら手順 3〜4 をスキップ**し、`herdr status` とだけ突き合わせて報告して終了(ローカルが検査済みバージョンより古ければ更新で直る項目に言及)。`force` 引数付きで呼ばれた場合のみスキップせず全照会する
3. `## Gaps` の各項目について上流の状態を照会する:
   - discussion リンク付きの項目は GraphQL で closed / stateReason を確認:
     ```sh
     GH_HOST=github.com gh api graphql -f query='query { repository(owner: "ogulcancelik", name: "herdr") { discussion(number: N) { closed stateReason comments(first: 10) { nodes { body } } } } }'
     ```
   - closed かつ "moved to issue ..." コメントがあれば昇格先 issue を確認:
     ```sh
     GH_HOST=github.com gh issue view N --repo ogulcancelik/herdr --comments
     ```
   - kangal-bot のコメントマーカーで判定する: `<!-- herdr:released:vX.Y.Z -->` = そのバージョンでリリース済み、`<!-- herdr:pending-release -->` = master 実装済み・未リリース
4. ローカルのバージョンと突き合わせ、分類する: `herdr status`(client と server 両方。server が古いままなら live-handoff 未実施の可能性に言及)
   - **未実装**: 上流 open のまま → 一覧に残す
   - **実装済み・要更新**: released バージョン > ローカル → 更新すれば解決することを報告(更新作業自体はこの skill の範囲外)
   - **解決済み**: released バージョン ≤ ローカル → `- [x]` にして `## Resolved` セクションへ移動
5. gist を更新する(`gh gist edit` はエディタが開くので使わない。API で非対話更新):
   - 手順 3〜4 を実施した場合は必ず `## 検査状況` の検査済みバージョンを照会した最新リリースに書き換え、`## 検査履歴` に 1 行追記する(日付、検査したバージョン、移動・変化した項目の要約)。項目に変化がなくてもこの 2 箇所は更新する(次回のスキップ判定のため)
   ```sh
   jq -n --rawfile c <更新後ファイル> '{files: {"herdr-gaps.md": {content: $c}}}' \
     | GH_HOST=github.com gh api -X PATCH gists/cd60ae40193d7340ca534812a3565162 --input - > /dev/null
   ```
6. 結果を要約して報告する(未実装 n 件 / 要更新 n 件 / 解決済みとして移動 n 件 / 検査済みバージョン)。

## 手順(`add <text>`)

`## Gaps` の末尾に `- [ ] <text>` を追記して手順 5 と同じ方法で PATCH する(検査状況・検査履歴は変更しない)。上流に対応する discussion/issue が既にないか軽く検索し(`GH_HOST=github.com gh search issues --repo ogulcancelik/herdr ...` と GraphQL の DISCUSSION search)、見つかればリンクを添える。

## 参考: herdr 本体の更新手順(pane を殺さずに)

「実装済み・要更新」を報告したとき、ユーザーが更新を求めたらこの手順で行う(バイナリは aqua 管理。`herdr update` / `herdr update --handoff` は herdr 自前の配布チャネルからバイナリを入れて aqua と二重管理になるため**使わない**):

1. `aqua.yaml` の `ogulcancelik/herdr@vX.Y.Z` をバンプして `aqua i`(この時点で PATH 上の client だけ新バージョンになり、稼働中 server は旧のまま)
2. live handoff でサーバを切り替える。**`--import-exe` の指定が必須**:
   ```sh
   # 実体パスの末尾 (herdr-<os>-<arch>) は環境により異なる。ls で確認するか
   # `find ~/.local/share/aquaproj-aqua/pkgs/github_release/github.com/ogulcancelik/herdr/vX.Y.Z -type f` で解決する
   herdr server live-handoff \
     --import-exe ~/.local/share/aquaproj-aqua/pkgs/github_release/github.com/ogulcancelik/herdr/vX.Y.Z/herdr-macos-aarch64/herdr-macos-aarch64 \
     --expected-version X.Y.Z
   ```
   - 罠: `--import-exe` を省略すると、旧サーバが**自分自身の実体パス**(aqua の pkgs 配下はバージョン固定パス)を再 exec するため、handoff は成功表示でも旧バージョンのまま立ち上がり直る(0.7.3→0.7.4 更新時に実際に踏んだ)
   - pane 内のプロセス(ssh・エージェント等)は生きたまま引き継がれる
3. `herdr status` で client / server の両方が新バージョンになり `restart_needed: no` であることを確認する

## 上流リポジトリの規約(照会時の前提)

- ogulcancelik/herdr の Issues はバグ専用。feature request は bot に closed され、Discussions(Ideas)が要望チャネル
- 新しく要望を出すときは他の discussion をクロスリファレンスせず単独で書く(ユーザーの方針)
- リリース判定は上記 kangal-bot マーカーが一次情報。リリースノート(`GH_HOST=github.com gh release view vX.Y.Z --repo ogulcancelik/herdr`)は補助
