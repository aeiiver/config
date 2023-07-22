#!/bin/sh

exec swayidle -w \
    timeout 600 '~/.config/hypr/scripts/waylock.sh' \
    timeout 630 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
