#!/usr/bin/env bash
#  ╔══════════════════════════════════════════════════════════════════╗
#  ║  mode-switch.sh — Detective Workstation productivity modes         ║
#  ║  Deploys per-mode layouts/apps, recolours the bar, fires a toast.  ║
#  ║  ~/.config/hypr/scripts/mode-switch.sh {mode|cycle|menu|restore}   ║
#  ╚══════════════════════════════════════════════════════════════════╝
set -euo pipefail

STATE="${XDG_RUNTIME_DIR:-/tmp}/dw-mode"
MODES=(programming cybersec osint study gaming)

# label · glyph · accent (matches Waybar #custom-mode classes)
declare -A LABEL=( [programming]="PROGRAMMING" [cybersec]="CYBERSEC" [osint]="OSINT" [study]="STUDY" [gaming]="GAMING" )
declare -A GLYPH=( [programming]="" [cybersec]="" [osint]="" [study]="" [gaming]="" )
declare -A DESC=(
  [programming]="Neovim · Kitty · Ranger tiled on I–III"
  [cybersec]="Burp · Wireshark · terminals on II–IV"
  [osint]="Firefox · Maltego · Tor · notes on II–IV"
  [study]="Obsidian · PDF · browser split on I–II"
  [gaming]="Steam · Discord on V"
)

current() { cat "$STATE" 2>/dev/null || echo "osint"; }

deploy() {
  # Launch the toolset for a mode. `silent` window rules in hyprland.conf
  # pin each app to its workspace; here we just summon what's missing.
  case "$1" in
    programming)
      hyprctl dispatch workspace 1
      pgrep -x kitty   >/dev/null || (kitty & )
      pgrep -x nvim    >/dev/null || (kitty -e nvim ~/Cases/_active/notes.md & )
      ;;
    cybersec)
      hyprctl dispatch workspace 2
      pgrep -f burp     >/dev/null || (burpsuite & ) 2>/dev/null || true
      pgrep -x wireshark>/dev/null || (wireshark & ) 2>/dev/null || true
      ;;
    osint)
      hyprctl dispatch workspace 2
      pgrep -x firefox  >/dev/null || (firefox & )
      pgrep -f maltego  >/dev/null || (maltego & ) 2>/dev/null || true
      # bring up the anonymity tunnel for OSINT by default
      "$(dirname "$0")/opsec-toggle.sh" up >/dev/null 2>&1 || true
      ;;
    study)
      hyprctl dispatch workspace 1
      pgrep -f obsidian >/dev/null || (obsidian & ) 2>/dev/null || true
      ;;
    gaming)
      hyprctl dispatch workspace 5
      pgrep -x steam    >/dev/null || (steam & ) 2>/dev/null || true
      ;;
  esac
}

set_mode() {
  local m="$1"
  echo "$m" > "$STATE"
  pkill -RTMIN+7 waybar 2>/dev/null || true   # signal=7 → custom/mode refresh
  notify-send -a "MODE" -u low -i preferences-desktop \
    "${LABEL[$m]} MODE" "${DESC[$m]}" -h string:x-dunst-stack-tag:mode
  deploy "$m"
}

case "${1:-cycle}" in
  cycle)
    cur="$(current)"; idx=0
    for i in "${!MODES[@]}"; do [[ "${MODES[$i]}" == "$cur" ]] && idx=$i; done
    set_mode "${MODES[$(( (idx + 1) % ${#MODES[@]} ))]}"
    ;;
  menu)
    pick="$(printf '%s\n' "${MODES[@]}" | rofi -dmenu -i -p "Mode" \
      -theme ~/.config/rofi/detective.rasi)"
    [[ -n "$pick" ]] && set_mode "$pick"
    ;;
  restore) set_mode "$(current)" ;;
  programming|cybersec|osint|study|gaming) set_mode "$1" ;;
  *) echo "usage: mode-switch.sh {${MODES[*]}|cycle|menu|restore}" >&2; exit 1 ;;
esac
