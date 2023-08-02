#!/bin/sh

exec swayidle -w \
	timeout 600 "$XDG_CONFIG_HOME/hypr/scripts/screenlock.sh" \
	timeout 630 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
