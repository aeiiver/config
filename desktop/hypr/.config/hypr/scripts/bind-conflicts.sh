#!/bin/sh

conflicted=$(hyprctl binds -j | jq '.[] | @text "\(.modmask) \(.key)"' | uniq -d)
if [ -z "$conflicted" ]; then
    echo 'No bind conflict was found.'
else
    echo "$conflicted"
fi
