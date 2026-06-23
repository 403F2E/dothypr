#!/usr/bin/env bash
#  quick-capture.sh — drop a timestamped note into the active case file.
#  Bound to SUPER+C. The detective's pocketbook.
set -euo pipefail
ACTIVE="$HOME/Cases/_active"
mkdir -p "$ACTIVE"
FILE="$ACTIVE/notes.md"
LABEL="$(cat "$ACTIVE/.case" 2>/dev/null || echo 'case')"

note="$(printf '' | rofi -dmenu -p "Capture → $LABEL" -theme ~/.config/rofi/detective.rasi)"
[[ -z "$note" ]] && exit 0

printf -- '- `%s` %s\n' "$(date '+%H:%M')" "$note" >> "$FILE"
notify-send -a "CAPTURE" -u low "Filed to $LABEL" "$note" -h string:x-dunst-stack-tag:capture
