#!/bin/sh

# install Homebrew
if ! which brew > /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew update

# install chezmoi
brew install chezmoi
