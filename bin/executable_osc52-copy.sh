#!/bin/sh

input=$(cat -)
printf "\033]52;c;%s\a" $(echo "$input" | base64)
