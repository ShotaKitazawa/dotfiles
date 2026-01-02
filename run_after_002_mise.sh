#!/usr/bin/env bash

echo "### run_after_002_mise.sh ###"

cd $HOME

# install mise
command -v mise >/dev/null || sh -c "curl https://mise.run | sh"
eval "$($HOME/.local/bin/mise activate zsh)"

# install plugins
mise i
