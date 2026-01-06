#!/usr/bin/env bash

echo "### run_after_002_mise.sh ###"

cd $HOME

# install mise
command -v mise >/dev/null || sh -c "curl https://mise.run | sh"

# install plugins
mise i

# cleanup unused plugins
mise prune -y
