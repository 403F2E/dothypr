#!/usr/bin/env bash

# Variables
rofi_theme="$HOME/.config/rofi/launchers/type-7/style-7.rasi"

# list of apps
list_apps=(kitty brave steam virt-manager)
flatpak_apps=("md.obsidian.Obsidian" "com.rtosta.zapzap" "com.discordapp.Discord" "com.obsproject.Studio" "com.spotify.Client")

kill_processes() {
  if pidof "$1" > /dev/null; then
    pkill "$1" &
  fi
}

run_apps() {
  if ! pidof "$1" >/dev/null; then
    "$1" &
    disown
  fi
}

kill_flatpak() {
  if flatpak ps | rg -q "$1"; then
    flatpak kill "$1" &
  fi
}

run_flatpak() {
  if ! flatpak ps | rg -q "$1"; then
    flatpak run "$1" &
  fi
}

chill_mode() {
  # kill kitty process if running
  kill_processes "${list_apps[0]}"
  # kill steam process if running
  kill_processes "${list_apps[2]}" 
  # kill virt-manager process if running
  kill_processes "${list_apps[3]}" 
  # kill obsidian process if running
  kill_flatpak "${flatpak_apps[0]}" 
  # kill obs process if running
  kill_flatpak "${flatpak_apps[3]}" 

  # run brave-browser
  run_apps "${list_apps[1]}"
  sleep 1
  # run zapzap
  run_flatpak "${flatpak_apps[1]}"
  sleep 1
  # run discord
  run_flatpak "${flatpak_apps[2]}"
  sleep 1
  # run spotify
  run_flatpak "${flatpak_apps[4]}"
}

dev_mode() {
  # kill steam process if running
  kill_processes "${list_apps[2]}" 
  # kill virt-manager process if running
  kill_processes "${list_apps[3]}" 
  # kill obsidian process if running
  kill_flatpak "${flatpak_apps[0]}" 
  # kill zapzap process if running
  kill_flatpak "${flatpak_apps[1]}"
  # kill discord process if running
  kill_flatpak "${flatpak_apps[2]}"
  # kill obs process if running
  kill_flatpak "${flatpak_apps[3]}" 

  # run kitty
  run_apps "${list_apps[0]}"
  sleep 1
  # run brave-browser
  run_apps "${list_apps[1]}"
  sleep 1
  # run spotify
  run_flatpak "${flatpak_apps[4]}"
}

cs_mode() {
  # kill steam process if running
  kill_processes "${list_apps[2]}" 
  # kill obsidian process if running
  kill_flatpak "${flatpak_apps[0]}" 
  # kill zapzap process if running
  kill_flatpak "${flatpak_apps[1]}" 
  # kill discord process if running
  kill_flatpak "${flatpak_apps[2]}" 
  # kill obs process if running
  kill_flatpak "${flatpak_apps[3]}" 

  # run kitty
  run_apps "${list_apps[0]}"
  sleep 1
  # run brave-browser
  run_apps "${list_apps[1]}"
  sleep 1
  # virt-manager
  run_apps "${list_apps[3]}"
  sleep 1
  # run spotify
  run_flatpak "${flatpak_apps[4]}"
}

stream_mode() {
  # kill steam process if running
  kill_processes "${list_apps[2]}" 
  # kill virt-manager process if running
  kill_processes "${list_apps[3]}" 
  # kill obsidian process if running
  kill_flatpak "${flatpak_apps[0]}" 
  # kill zapzap process if running
  kill_flatpak "${flatpak_apps[1]}"
  # kill discord process if running
  kill_flatpak "${flatpak_apps[2]}"
  # kill spotify process if running
  kill_flatpak "${flatpak_apps[4]}"

  # run kitty
  run_apps "${list_apps[0]}"
  sleep 1
  # run brave-browser
  run_apps "${list_apps[1]}"
  sleep 1
  # run obs
  run_apps "${flatpak_apps[3]}"
}

osint_mode() {
  # kill steam process if running
  kill_processes "${list_apps[2]}" 
  # kill virt-manager process if running
  kill_processes "${list_apps[3]}" 
  # kill zapzap process if running
  kill_flatpak "${flatpak_apps[1]}" 
  # kill discord process if running
  kill_flatpak "${flatpak_apps[2]}" 
  # kill obs process if running
  kill_flatpak "${flatpak_apps[3]}" 

  # run kitty
  run_apps "${list_apps[0]}"
  sleep 1
  # run brave-browser
  run_apps "${list_apps[1]}"
  sleep 1
  # run obsidian
  run_flatpak "${flatpak_apps[0]}"
  sleep 1
  # run spotify
  run_flatpak "${flatpak_apps[4]}"
}

study_mode() {
  # kill steam process if running
  kill_processes "${list_apps[2]}" 
  # kill virt-manager process if running
  kill_processes "${list_apps[3]}" 
  # kill zapzap process if running
  kill_flatpak "${flatpak_apps[1]}" 
  # kill discord process if running
  kill_flatpak "${flatpak_apps[2]}" 
  # kill obs process if running
  kill_flatpak "${flatpak_apps[3]}" 
  # kill spotify process if running
  kill_flatpak "${flatpak_apps[4]}" 

  # run kitty
  run_apps "${list_apps[0]}"
  sleep 1
  # run brave-browser
  run_apps "${list_apps[1]}"
  sleep 1
  # run obsidian
  run_flatpak "${flatpak_apps[0]}"
}

gaming_mode() {
  # kill kitty process if running
  kill_processes "${list_apps[0]}"
  # kill brave-browser process if running
  kill_processes "${list_apps[1]}"
  # kill virt-manager process if running
  kill_processes "${list_apps[3]}" 
  # kill obsidian process if running
  kill_flatpak "${flatpak_apps[0]}" 
  # kill zapzap process if running
  kill_flatpak "${flatpak_apps[1]}" 
  # kill discord process if running
  kill_flatpak "${flatpak_apps[2]}" 
  # kill obs process if running
  kill_flatpak "${flatpak_apps[3]}" 

  # run steam
  run_flatpak "${list_apps[2]}" 
  sleep 1
  # run spotify
  run_flatpak "${flatpak_apps[4]}"
}

# Switching mode function
switch_mode() {
  local mode="$2"

  # mode
  free="Free"
  chill="Chilling"
  dev="Programming"
  cs="CyberSecurity"
  stream="Streaming"
  osint="OSINT"
  study="Study"
  gaming="Gaming"

  case "$mode" in
    "$free")
      notify-send "Do whatever : Free Mode"
      echo "Free Mode" > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$chill")
      chill_mode
      notify-send "Maybe I ll be just : $mode"
      echo "$mode" > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$dev")
      dev_mode
      notify-send "program in : $mode"
      echo "$mode" > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$cs") 
      cs_mode
      notify-send "Hack with : $mode"
      echo "$mode" > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$stream") 
      stream_mode
      notify-send "Let's go live : $mode"
      echo "$mode" > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$osint") 
      osint_mode
      notify-send "Lookup : $mode"
      echo "$mode" > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$study") 
      study_mode
      notify-send "Study Hard in : $mode"
      echo "$mode" > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "$gaming")
      gaming_mode
      notify-send "play with : $mode"
      echo "$mode" > ~/.config/hypr/state/mode.status
      pkill -RTMIN+8 waybar
      ;;
    "");;
    *)
      notify-send "Unknown mode : $mode"
      echo "Free Mode" > ~/.config/hypr/state/mode.status
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
😎 Free Mode
❄️ Chilling
💻 Programming
🧑‍💻 CyberSecurity
🌐 Streaming
🕵️ OSINT
📔 Study
🎮 Gaming
