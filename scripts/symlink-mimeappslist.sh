#!/bin/sh

set -e

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"

target=$XDG_CONFIG_HOME/mimeapps.list
dest_dir=$XDG_DATA_HOME/applications
dest=$dest_dir/mimeapps.list

if [ ! -e "$target" ]; then
	echo "'$target' was not found."
	echo "I can't create a symlink pointing to nothing!"
	exit 1
fi

mkdir -pv "$dest_dir"
ln -sv "$target" "$dest"
echo "Done."
