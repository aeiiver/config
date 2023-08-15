#!/bin/sh

gamemode_enabled=$(hyprctl getoption decoration:blur:enabled | awk 'NR==2{print $2}')
if [ "$gamemode_enabled" = 1 ]; then
	hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 0;\
        keyword decoration:rounding 0"
	notify-send "Gamemode enabled"
	exit
fi
hyprctl reload
notify-send "Gamemode disabled"
