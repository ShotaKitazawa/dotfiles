#!/usr/bin/env bash

echo "### run_once_001_postscript-zshrc.sh ###"

if ! grep -q .shell/all ~/.bashrc; then
  echo "if [ -f ~/.shell/all ]; then . ~/.shell/all; fi" >> ~/.bashrc
fi

if ! grep -q .shell/all ~/.zshrc; then
  echo "if [ -f ~/.shell/all ]; then . ~/.shell/all; fi" >> ~/.zshrc
fi
