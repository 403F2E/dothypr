#!/usr/bin/env bash

# Variables
rofi_theme="$HOME/.config/rofi/launchers/type-7/style-7.rasi"

dev="💻 Programming"
cs="🧑‍💻 CyberSecurity"
osint="🕵️ OSINT"
study="📔 Study"
gaming="🎮 Gaming"

# Switching language function
switch_mode() {
  local mode="$1 $2"

  case "$mode" in
    "$dev")
      notify-send "program in : $mode"
      echo $mode > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$cs") 
      notify-send "Hack with : $mode"
      echo $mode > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$osint") 
      notify-send "Lookup : $mode"
      echo $mode > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$study") 
      notify-send "do u know in : $mode"
      echo $mode > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$gaming")
      notify-send "play with : $mode"
      echo $mode > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    " ");;
    *)
      notify-send "Unknown mode : $mode"
      echo "💻 Programming" > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
  esac
}

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

mode=$(
    sed '1,/^# # MODE # #$/d' "$0" | \
    rofi -i -dmenu -config "$rofi_theme"
)

switch_mode $mode

exit

# # MODE # #
💻 Programming
🧑‍💻 CyberSecurity
🕵️ OSINT
📔 Study
🎮 Gaming
