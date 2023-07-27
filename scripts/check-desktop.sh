#!/bin/sh

IFS="$(printf '\n')"
while read -r line; do
	if grep -Prq "\b$line\b" desktop; then
		printf '%s: \033[92mok\033[0m\n' "$line"
	else
		printf '%s: \033[91mabsent\033[0m\n' "$line"
	fi
done <pkglist.desktop
