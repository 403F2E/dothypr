#!/usr/bin/env bash

CASE_FILE="$HOME/.cache/current_case"

CASE=$(cat "$CASE_FILE" 2>/dev/null)

[ -z "$CASE" ] && CASE="No Active Investigation"

printf '{"text":"%s"}\n' "$CASE"

