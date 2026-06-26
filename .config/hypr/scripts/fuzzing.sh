#!/usr/bin/env bash

if ! command -v fzf > /dev/null 2>&1; then
  notify-send -u critical "Error: fzf not found."
fi

if ! command -v nvim > /dev/null 2>&1; then
  notify-send -u critical "Error: nvim not found."
fi

local target
cd /
target=$(fzf --preview='bat --color=always {}') || exit 1
cd "$(dirname "$target")" && nvim .
