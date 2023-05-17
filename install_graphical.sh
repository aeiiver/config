#!/bin/bash

# dependencies to run this script:
#   base-devel

# environment variables
AUR_HELPER=${AUR_HELPER:-yay}

# don't run as root
if [ $EUID -eq 0 ]; then
	printf 'Why are you running me as root?\n'
	exit 1
fi

if command -v "$AUR_HELPER" >/dev/null; then
	printf '%s was found.\n' "$AUR_HELPER"
else
	printf '%s was not found. Installing %s...\n' "$AUR_HELPER" "$AUR_HELPER"
	sudo pacman -S --needed --noconfirm git

	tmp=$(mktemp -dp .)
	trap "rm -rf $tmp" SIGHUP SIGINT SIGQUIT SIGABRT SIGTERM

	git clone https://aur.archlinux.org/"$AUR_HELPER".git "$tmp"
	cd "$tmp" || exit 1
	makepkg -sri --noconfirm
	cd ..

	rm -rf "$tmp"
fi

if command -v stow >/dev/null; then
	printf 'stow was found.\n'
else
	printf 'stow was not found. Installing stow...\n'
	sudo pacman -S --needed --noconfirm stow
fi

sed -n '/^# graphical environment$/,/^$/p' README.md | sort | sed '1,/#/d' |
	"$AUR_HELPER" -S --needed -
cd "$(dirname $0)"/graphical
stow *
