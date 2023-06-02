#!/bin/bash

### Environment variables

AUR_HELPER=${AUR_HELPER:-yay}

### Main script

# Don't run with root privileges
if [ $EUID -eq 0 ]; then
	echo "Don't run this script with root privileges."
	exit 1
fi

# Prepare AUR helper
if command -v "$AUR_HELPER" >/dev/null; then
	echo "$AUR_HELPER was found."
else
	while :; do
		read -rp "$AUR_HELPER was not found. Install $AUR_HELPER? [y/n]: " yn
		case "$yn" in
		y | Y) break ;;
		n | N)
			cat <<-EOF
				An AUR helper is required in order to install the graphical environment.
				You can install one yourself, then run this script again with the environment
				variable 'AUR_HELPER' set to it.
			EOF
			exit 1
			;;
		*) echo "I don't understand." ;;
		esac
		unset yn
	done

	sudo pacman -S --needed --noconfirm git
	tmp=$(mktemp -dp .)
	trap 'rm -rf $tmp' SIGHUP SIGINT SIGQUIT SIGABRT SIGTERM

	git clone https://aur.archlinux.org/"$AUR_HELPER".git "$tmp"
	if [ -z "$(ls -A "$tmp")" ]; then
		cat <<-EOF
			$AUR_HELPER couldn't be found in the AUR.
			If you're sure it exists, you can install it yourself, then run this script
			again with the environment variable 'AUR_HELPER' set to it.
		EOF
		exit 1
	fi

	(
		cd "$tmp" || printf 'cd failed' && exit 1
		makepkg -sri --noconfirm
	) || printf 'makepkg failed' && exit 1

	rm -rf "$tmp"
fi

# Use stow as symlink farmer
if command -v stow >/dev/null; then
	echo 'stow was found.'
else
	echo 'stow was not found. Installing stow...'
	sudo pacman -S --needed --noconfirm stow
fi

# Install
sed -n '/^# graphical environment$/,/^$/p' README.md | sort | sed '1,/#/d' | "$AUR_HELPER" -S --needed -

# Configure
(
	cd graphical || printf 'cd failed' && exit 1
	stow ./*
) || printf 'stow failed' && exit 1

bemoji -D all
