#!/usr/bin/env bash
#  mode-status.sh — emits Waybar JSON for the current productivity mode.
#  Wired to custom/mode (return-type json, signal 7).
set -euo pipefail
STATE="${XDG_RUNTIME_DIR:-/tmp}/dw-mode"
m="$(cat "$STATE" 2>/dev/null || echo osint)"

declare -A LABEL=( [programming]="PROGRAMMING" [cybersec]="CYBERSEC" [osint]="OSINT" [study]="STUDY" [gaming]="GAMING" )
declare -A GLYPH=( [programming]="" [cybersec]="" [osint]="" [study]="" [gaming]="" )
declare -A DESC=(
  [programming]="Neovim · Kitty · Ranger — workspaces I–III"
  [cybersec]="Burp · Wireshark · terminals — II–IV"
  [osint]="Firefox · Maltego · Tor · notes — II–IV"
  [study]="Obsidian · PDF · browser — I–II"
  [gaming]="Steam · Discord — V"
)

# Pango markup gives the label the letter-spacing GTK CSS can't (the chip
# reads like a struck seal). letter_spacing is in 1/1024 pt units.
text="${GLYPH[$m]}  <span letter_spacing='1700'>${LABEL[$m]}</span>"

printf '{"text":"%s","tooltip":"%s\\nclick: cycle · right-click: menu","class":"%s","alt":"%s"}\n' \
  "$text" "${DESC[$m]}" "$m" "$m"
