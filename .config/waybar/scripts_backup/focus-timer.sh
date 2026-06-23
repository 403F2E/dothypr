#!/usr/bin/env bash
#  focus-timer.sh — "On the case" pomodoro, tied to the active case.
#  Waybar custom/focus: {status|toggle|reset}. JSON out on `status`.
set -euo pipefail

DIR="${XDG_RUNTIME_DIR:-/tmp}"
F_END="$DIR/dw-focus-end"      # epoch when current session ends
F_PAUSE="$DIR/dw-focus-pause"  # seconds remaining when paused (absent = running)
LEN=$(( 25 * 60 ))             # 25-minute sessions
CASE_FILE="$HOME/Cases/_active/.case"
case_label() { [[ -f "$CASE_FILE" ]] && cat "$CASE_FILE" || echo "NO CASE"; }

now() { date +%s; }

start() { echo $(( $(now) + LEN )) > "$F_END"; rm -f "$F_PAUSE"; }

remaining() {
  if [[ -f "$F_PAUSE" ]]; then cat "$F_PAUSE"; return; fi
  if [[ -f "$F_END" ]]; then
    local r=$(( $(cat "$F_END") - $(now) ))
    (( r < 0 )) && r=0
    echo "$r"
  else echo "$LEN"; fi
}

case "${1:-status}" in
  toggle)
    if [[ -f "$F_PAUSE" ]]; then            # resume
      echo $(( $(now) + $(cat "$F_PAUSE") )) > "$F_END"; rm -f "$F_PAUSE"
    elif [[ -f "$F_END" ]]; then            # pause
      remaining > "$F_PAUSE"; rm -f "$F_END"
    else start; fi
    pkill -RTMIN+8 waybar 2>/dev/null || true
    ;;
  reset) rm -f "$F_END" "$F_PAUSE"; pkill -RTMIN+8 waybar 2>/dev/null || true ;;
  status)
    r="$(remaining)"; mm=$(printf '%02d' $(( r / 60 ))); ss=$(printf '%02d' $(( r % 60 )))
    cls="paused"; [[ -f "$F_END" ]] && cls="running"
    if [[ -f "$F_END" && "$r" -eq 0 ]]; then
      notify-send -a "FOCUS" "Session complete" "$(case_label) — take five." 2>/dev/null || true
      rm -f "$F_END"
    fi
    printf '{"text":"%s · %s","class":"%s","tooltip":"Case: %s\\nclick: pause/resume · right-click: reset"}\n' \
      "$(case_label)" "${mm}:${ss}" "$cls" "$(case_label)"
    ;;
esac
