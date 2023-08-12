#!/bin/sh

if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
	echo 'Hyprland is probably not running'
	exit 1
fi

conflicts=$(
	hyprctl binds -j |
		jq -r 'sort_by(.modmask, .key)[]
		           | @text "\(.modmask) \(
			       if .key == "" then .keycode
	                       else .key
			       end)"' |
		uniq -d
)
if [ -z "$conflicts" ]; then
	echo 'No bind conflict was found'
else
	echo "$conflicts"
fi
