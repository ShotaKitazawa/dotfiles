#!/usr/bin/env bash

if ! grep .shell/all ~/.bashrc > /dev/null 2>&1; then
  echo "if [ -f ~/.shell/all ]; then . ~/.shell/all; fi" >> ~/.bashrc
fi

if ! grep .shell/all ~/.zshrc > /dev/null 2>&1; then
  echo "if [ -f ~/.shell/all ]; then . ~/.shell/all; fi" >> ~/.zshrc
fi
