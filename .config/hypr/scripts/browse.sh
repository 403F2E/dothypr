#/usr/bin/env zsh

rofi_theme="$HOME/.config/rofi/launchers/type-1/style-5.rasi"
msg='‼️ **note** ‼️ search via default web browser'

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
fi


# Open Rofi and pass the selected query to xdg-open for Brave search
query=$(rofi -dmenu -mesg "$msg" -p "󰍉" -theme $rofi_theme)

[[ -z "$query" ]] && exit 0

xdg-open "https://search.brave.com/search?q=${query// /+}"
