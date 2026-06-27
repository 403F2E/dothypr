#!/usr/bin/env bash

rofi_theme="~/.config/rofi/launchers/type-1/style-5.rasi"

rofi \
    -show calc \
    -modi calc \
    -theme "$rofi_theme"
