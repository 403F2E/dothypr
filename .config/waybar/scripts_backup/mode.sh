#!/usr/bin/env bash

MODE_FILE="$HOME/.cache/workstation_mode"

MODE=$(cat "$MODE_FILE" 2>/dev/null)

case "$MODE" in
  "DEVELOPMENT")
    MODE="CYBER"
    TEXT="󰞀 THREAT ANALYSIS"
    CLASS="cyber"
    ;;
  "CYBER")
    MODE="OSINT"
    TEXT="󰛳 INVESTIGATION"
    CLASS="osint"
    ;;
  "OSINT")
    MODE="STUDY"
    TEXT="󰗚 RESEARCH"
    CLASS="study"
    ;;
  "STUDY")
    MODE="GAMING"
    TEXT="󰊗 RECREATION"
    CLASS="gaming"
    ;;
  *)
    MODE="DEVELOPMENT"
    TEXT="󰆍 DEVELOPMENT"
    CLASS="programming"
    ;;
esac

echo "$MODE" > "$MODE_FILE"
printf '{"text":"%s","class":"%s"}\n' "$TEXT" "$CLASS"
