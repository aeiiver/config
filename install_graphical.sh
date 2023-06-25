#!/bin/bash

AUR_HELPER=${AUR_HELPER:-yay}

if [ $EUID -eq 0 ]; then
	echo "Don't run this script with root privileges."
	exit 1
fi

if command -v "$AUR_HELPER" >/dev/null; then
	echo "'$AUR_HELPER' was found."
else
	while :; do
		read -rp "'$AUR_HELPER' was not found. Install '$AUR_HELPER'? [y/n]: " yn
		case "$yn" in
		y | Y) break ;;
		n | N)
			cat <<-EOF
				An AUR helper is required in order to install the graphical environment. Run
				this script with the environment variable 'AUR_HELPER' set to the AUR helper of
				your choice. 'yay' is the default.
			EOF
			exit 1
			;;
		*) echo "I don't understand. Please answer 'y' or 'n'." ;;
		esac
		unset yn
	done

	sudo pacman -S --needed --noconfirm git

	tmp=$(mktemp -dp .)
	trap 'rm -rf $tmp' SIGHUP SIGINT SIGQUIT SIGABRT SIGTERM

	git clone https://aur.archlinux.org/"$AUR_HELPER".git "$tmp"
	if [ -z "$(ls -A "$tmp")" ]; then
		cat <<-EOF
			'$AUR_HELPER' couldn't be found in the AUR. If you're sure it exists, you can
			install it yourself, then run this script again with the environment variable
			'AUR_HELPER' set to it.
		EOF
		exit 1
	fi

	(
		cd "$tmp" || printf 'cd failed' && exit 1
		makepkg -sri --noconfirm
	) || echo "makepkg: failed to install '$AUR_HELPER'" && exit 1

	rm -rf "$tmp"
fi

if command -v stow >/dev/null; then
	echo 'stow was found.'
else
	echo 'stow was not found. Installing stow...'
	sudo pacman -S --needed --noconfirm stow
fi

sed -n '/^# graphical environment$/,/^$/p' README.md | sort | sed '1,/#/d; s/\s*#.*//' | "$AUR_HELPER" -S --needed -

(
	cd graphical || printf 'cd failed' && exit 1
	stow ./*
) || printf 'stow: failed to symlink' && exit 1
bemoji -D all
