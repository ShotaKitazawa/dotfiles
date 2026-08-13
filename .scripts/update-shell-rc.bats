#!/usr/bin/env bats

setup() {
  update_script="$BATS_TEST_DIRNAME/update-shell-rc.sh"
  target="$BATS_TEST_TMPDIR/zshrc"
  begin_marker='# >>> github.com/ShotaKitazawa/dotfiles managed block (do not edit by hand) >>>'
  end_marker='# <<< github.com/ShotaKitazawa/dotfiles managed block <<<'
}

update_target() {
  printf '%s' "$1" | "$update_script" "$target"
}

file_mode() {
  stat -f '%Lp' "$1" 2>/dev/null || stat -c '%a' "$1"
}

@test "adds one managed block and remains idempotent without a final newline" {
  printf 'keep-without-final-newline' > "$target"

  update_target $'export NEW=1\n'
  cp "$target" "$BATS_TEST_TMPDIR/first-result"
  update_target $'export NEW=1\n'

  cmp -s "$target" "$BATS_TEST_TMPDIR/first-result"
  [ "$(grep -cF "$begin_marker" "$target")" -eq 1 ]
  [ "$(grep -cF "$end_marker" "$target")" -eq 1 ]
  grep -qxF 'keep-without-final-newline' "$target"
}

@test "replaces the existing block and preserves unrelated lines" {
  cat > "$target" <<EOF
keep-before
$begin_marker
export OLD=1
$end_marker
keep-after
EOF

  update_target $'export NEW=1\n'

  grep -qxF 'keep-before' "$target"
  grep -qxF 'keep-after' "$target"
  grep -qxF 'export NEW=1' "$target"
  ! grep -qF 'export OLD=1' "$target"

  expected=$(cat <<EOF
keep-before
$begin_marker
export NEW=1
$end_marker
keep-after
EOF
)
  [ "$(cat "$target")" = "$expected" ]
}

@test "rejects an unterminated block without modifying the target" {
  cat > "$target" <<EOF
keep
$begin_marker
valuable-line
EOF
  cp "$target" "$BATS_TEST_TMPDIR/before"

  run update_target $'export NEW=1\n'

  [ "$status" -ne 0 ]
  cmp -s "$target" "$BATS_TEST_TMPDIR/before"
}

@test "preserves the target file mode" {
  printf 'keep\n' > "$target"
  chmod 640 "$target"

  update_target $'export NEW=1\n'

  [ "$(file_mode "$target")" = 640 ]
}

@test "updates a symlink referent without replacing the symlink" {
  referent="$BATS_TEST_TMPDIR/referent"
  link="$BATS_TEST_TMPDIR/link"
  printf 'keep\n' > "$referent"
  ln -s "$referent" "$link"
  target="$link"

  update_target $'export NEW=1\n'

  [ -L "$link" ]
  grep -qxF 'export NEW=1' "$referent"
}

@test "rejects managed-block markers in the payload" {
  printf 'keep\n' > "$target"

  run update_target "$begin_marker"

  [ "$status" -ne 0 ]
  [ "$(cat "$target")" = keep ]
}
