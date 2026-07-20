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
