#!/usr/bin/env bash

MODE_FILE="$HOME/.cache/workstation_mode"

MODE=$(cat "$MODE_FILE" 2>/dev/null)

case "$MODE" in
  CYBER)
    TEXT="󰞀 THREAT ANALYSIS"
    CLASS="cyber"
    ;;
  OSINT)
    TEXT="󰛳 INVESTIGATION"
    CLASS="osint"
    ;;
  STUDY)
    TEXT="󰗚 RESEARCH"
    CLASS="study"
    ;;
  GAMING)
    TEXT="󰊗 RECREATION"
    CLASS="gaming"
    ;;
  *)
    TEXT="󰆍 DEVELOPMENT"
    CLASS="programming"
    ;;
esac

printf '{"text":"%s","class":"%s"}\n' "$TEXT" "$CLASS"
