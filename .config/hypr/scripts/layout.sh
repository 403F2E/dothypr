#!/usr/bin/env bash

# Variables
rofi_theme="$HOME/.config/rofi/launchers/type-7/style-7.rasi"

# Switching language function
switch_layout() {
  local lang=$1

  case "$1" in
    gb) 
      fcitx-remote -c

      if pidof fcitx5 > /dev/null; then
        pkill fcitx5
      fi

      hyprctl switchxkblayout current 0
      ;;
    us) 
      fcitx-remote -c

      if pidof fcitx5 > /dev/null; then
        pkill fcitx5
      fi

      hyprctl switchxkblayout current 1
      ;;
    ara) 
      fcitx-remote -c

      if pidof fcitx5 > /dev/null; then
        pkill fcitx5
      fi

      hyprctl switchxkblayout current 2
      ;;
    jp)
      hyprctl switchxkblayout current 3
      fcitx5 -d
      sleep 2
      fcitx-remote -o
      ;;
  esac
}

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

layout=$(
    sed '1,/^# # LAYOUT # #$/d' "$0" |
    rofi -i -dmenu -config "$rofi_theme" |
    sed -n 's/.*(\([^)]*\)).*/\1/p'
)

switch_layout $layout

exit

# # LAYOUT # #
🇬🇧 English (gb)
🇺🇸 English (us)
🇯🇵 Japanese, mozc (jp)
🇵🇸 Arabic (ara)
