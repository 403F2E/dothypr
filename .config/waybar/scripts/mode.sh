#!/bin/bash

MODE_FILE="$HOME/.config/hypr/current_mode"

if [ -f "$MODE_FILE" ]; then
    cat "$MODE_FILE"
else
    echo "🖥 DEV"
fi
