#!/bin/sh

if [ -z "$XDG_CONFIG_HOME" ]; then
  XDG_CONFIG_HOME=$HOME/.config/
fi

STATUS_FILE="$XDG_CONFIG_HOME/hypr/state/touchpad.status"

enable_touchpad() {
  printf "true" > "$STATUS_FILE"

  hyprctl reload

  notify-send -u normal "Enabling Touchpad"
}

disable_touchpad() {
  printf "false" > "$STATUS_FILE"

  hyprctl reload

  notify-send -u normal "Disabling Touchpad"
}

if ! [ -f "$STATUS_FILE" ]; then
  enable_touchpad
else
  if [ $(cat "$STATUS_FILE") = "true" ]; then
    disable_touchpad
  elif [ $(cat "$STATUS_FILE") = "false" ]; then
    enable_touchpad
  fi
fi
