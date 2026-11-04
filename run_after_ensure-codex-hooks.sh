#!/usr/bin/env bash
set -euo pipefail

command -v codex >/dev/null 2>&1 || exit 0

if codex features list | awk '
  $1 == "hooks" && $NF == "true" { enabled = 1 }
  END { exit enabled ? 0 : 1 }
'; then
  exit 0
fi

codex features enable hooks
