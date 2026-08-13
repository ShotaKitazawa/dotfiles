#!/usr/bin/env bash
set -euo pipefail

# Idempotently keeps a marked block in a zsh rc file in sync with stdin.
# ~/.zshrc itself is owned by the public dotfiles repo (not chezmoi-managed
# here), so lines this repo needs in it (env vars, etc.) are synced into a
# single delimited block instead of being appended ad hoc.
# Safe to run repeatedly: adding, editing, or removing a line on stdin is
# reflected in the block on the next run; everything else in the target
# file is left untouched.
#
# Usage: update-shell-rc.sh <target-file> <<'EOF'
# export FOO=bar
# EOF

begin_marker='# >>> github.com/ShotaKitazawa/dotfiles managed block (do not edit by hand) >>>'
end_marker='# <<< github.com/ShotaKitazawa/dotfiles managed block <<<'

target_file="${1:?usage: update-shell-rc.sh <target-file>}"

touch "$target_file"

tmp_dir=$(mktemp -d "${target_file}.tmp.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT

payload_file="$tmp_dir/payload"
new_file="$tmp_dir/new"
replacement_file="$tmp_dir/replacement"

cat > "$payload_file"

# Marker-looking lines in the payload would make the next update ambiguous.
if grep -qxF "$begin_marker" "$payload_file" ||
   grep -qxF "$end_marker" "$payload_file"; then
  echo "update-shell-rc.sh: managed-block marker found in stdin" >&2
  exit 1
fi

# Accept exactly zero or one well-formed managed block. Refuse to modify the
# target if a marker is missing, out of order, or duplicated: silently trying
# to recover could discard unrelated shell configuration.
if ! awk -v begin="$begin_marker" -v end="$end_marker" '
  BEGIN { in_block = 0; blocks = 0 }
  $0 == begin {
    if (in_block || blocks > 0) exit 2
    in_block = 1
    blocks++
    next
  }
  $0 == end {
    if (!in_block) exit 3
    in_block = 0
    next
  }
  END { if (in_block) exit 4 }
' "$target_file"; then
  echo "update-shell-rc.sh: malformed managed block in $target_file" >&2
  exit 1
fi

# Replace an existing block in place so the evaluation order of the surrounding
# shell configuration does not change. Only append when no block exists yet.
# awk also supplies a missing final newline in both existing text and stdin.
awk -v begin="$begin_marker" -v end="$end_marker" -v payload="$payload_file" '
  function print_payload(  line) {
    while ((getline line < payload) > 0) print line
    close(payload)
  }
  $0 == begin {
    found = 1
    in_block = 1
    print
    print_payload()
    next
  }
  $0 == end {
    in_block = 0
    print
    next
  }
  !in_block { print }
  END {
    if (!found) {
      print begin
      print_payload()
      print end
    }
  }
' "$target_file" > "$new_file"

# Avoid needless inode and mtime changes when the desired contents already
# match the target.
if cmp -s "$new_file" "$target_file"; then
  exit 0
fi

if [[ -L "$target_file" ]]; then
  # Write through a symlink instead of replacing the link itself.
  cat "$new_file" > "$target_file"
else
  # Seed the replacement from the original so mode and other attributes are
  # retained, then atomically replace the regular file from the same directory.
  cp -p "$target_file" "$replacement_file"
  cat "$new_file" > "$replacement_file"
  mv "$replacement_file" "$target_file"
fi
