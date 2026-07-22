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
  user)
    base="$HOME"
    ;;
  project)
    base="$PWD"
    ;;
  target)
    [ -n "$target_dir" ] || { echo "--target requires a directory" >&2; exit 1; }
    base="$(cd "$target_dir" && pwd)"
    ;;
esac

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
      # Claude Code's skill loader doesn't treat a symlinked *directory* as
      # a valid skill directory, so keep $dest a real directory tree and
      # symlink each file individually back to the dotfiles source instead.
      # A tool-mediated edit that resolves symlinks (Claude Code's
      # Edit/Write) then errors instead of silently diverging from
      # dotfiles; a shell-level write (redirection, sed without -i) still
      # transparently updates the real source file through the symlink.
      [ ! -L "$dest" ] || rm "$dest"
      [ ! -e "$dest" ] || rm -rf "$dest"
      mkdir -p "$dest"
      find "$d" -mindepth 1 -type d -print0 | while IFS= read -r -d '' sub; do
        mkdir -p "$dest/${sub#"$d"/}"
      done
      find "$d" -type f -print0 | while IFS= read -r -d '' file; do
        ln -s "$file" "$dest/${file#"$d"/}"
      done
    else
      [ ! -L "$dest" ] || rm "$dest"
      [ ! -e "$dest" ] || rm -rf "$dest"
      ln -s "$d" "$dest"
    fi
  done
done
