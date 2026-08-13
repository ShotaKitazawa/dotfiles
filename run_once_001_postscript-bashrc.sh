#!/usr/bin/env bash

echo "### run_once_001_postscript-bashrc.sh ###"

if ! grep -q .shell/all ~/.bashrc; then
  echo "if [ -f ~/.shell/all ]; then . ~/.shell/all; fi" >> ~/.bashrc
fi
