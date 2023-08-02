#!/bin/sh

"$@" &
sleep 0.2
if ! hyprctl activewindow | grep -q scratchpad; then
	hyprctl dispatch togglespecialworkspace scratchpad
fi
