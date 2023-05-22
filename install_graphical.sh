#!/bin/bash

# environment variables
AUR_HELPER=${AUR_HELPER:-yay}

# don't run with root privileges
if [ $EUID -eq 0 ]; then
	printf "Don't run this script with root privileges.\n"
	printf 'Exiting...\n'
	exit 1
fi

# prepare AUR helper
if command -v "$AUR_HELPER" >/dev/null; then
	printf '%s was found.\n' "$AUR_HELPER"
else
	printf '%s was not found. Installing %s...\n' "$AUR_HELPER" "$AUR_HELPER"
	sudo pacman -S --needed --noconfirm git

	tmp=$(mktemp -dp .)
	trap 'rm -rf $tmp' SIGHUP SIGINT SIGQUIT SIGABRT SIGTERM

	git clone https://aur.archlinux.org/"$AUR_HELPER".git "$tmp"
	cd "$tmp" || printf 'cd failed' && exit 1
	makepkg -sri --noconfirm
	cd ..

	rm -rf "$tmp"
fi

# use stow as symlink farmer
if command -v stow >/dev/null; then
	printf 'stow was found.\n'
else
	printf 'stow was not found. Installing stow...\n'
	sudo pacman -S --needed --noconfirm stow
fi

# install
sed -n '/^# graphical environment$/,/^$/p' README.md | sort | sed '1,/#/d' |
	"$AUR_HELPER" -S --needed -
cd "$(dirname "$0")"/graphical || printf 'cd failed' && exit 1

# configure
stow ./*
bemoji -D all
