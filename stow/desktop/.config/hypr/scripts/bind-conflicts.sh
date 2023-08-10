#!/bin/sh

if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
	echo 'Hyprland is probably not running'
	exit 1
fi

conflicted=$(hyprctl binds -j | jq '.[] | @text "\(.modmask) \(.key)"' | uniq -d)
if [ -z "$conflicted" ]; then
    echo 'No bind conflict was found'
else
    echo "$conflicted"
fi
