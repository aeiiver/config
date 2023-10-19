#!/bin/sh

set -e

if [ -z "$XDG_CONFIG_HOME" ] || [ -z "$XDG_DATA_HOME" ]; then
	echo 'ERROR: XDG_CONFIG_HOME and XDG_DATA_HOME environment variables should be set' 1>&2
	exit 1
fi

yay -S stow - <./pkglist-desktop.txt
bemoji -D all
cd ./stow
stow -v desk

if [ ! -e "$XDG_CONFIG_HOME/mimeapps.list" ]; then
	echo "INTERNAL ERROR: $XDG_CONFIG_HOME/mimeapps.list should exist after stowing the 'desk' package" 1>&2
	exit 2
fi

mkdir -pv "$XDG_DATA_HOME/applications"
ln -sv "$XDG_CONFIG_HOME/mimeapps.list" "$XDG_DATA_HOME/applications/mimeapps.list"

echo "Done."
