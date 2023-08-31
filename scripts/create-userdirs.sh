#!/usr/bin/env sh

: "${XDG_CONFIG_HOME:=$HOME/.config}"
userdirs=$XDG_CONFIG_HOME/user-dirs.dirs

if [ ! -e "$userdirs" ]; then
	echo "'$userdirs' was not found."
	echo "I don't know what to create!"
	exit 1
fi

# shellcheck disable=1090
. "$userdirs"

[ -n "$XDG_DESKTOP_DIR"     ] && mkdir -pv "$XDG_DESKTOP_DIR"
[ -n "$XDG_DOCUMENTS_DIR"   ] && mkdir -pv "$XDG_DOCUMENTS_DIR"
[ -n "$XDG_DOWNLOAD_DIR"    ] && mkdir -pv "$XDG_DOWNLOAD_DIR"
[ -n "$XDG_MUSIC_DIR"       ] && mkdir -pv "$XDG_MUSIC_DIR"
[ -n "$XDG_PICTURES_DIR"    ] && mkdir -pv "$XDG_PICTURES_DIR"
[ -n "$XDG_PUBLICSHARE_DIR" ] && mkdir -pv "$XDG_PUBLICSHARE_DIR"
[ -n "$XDG_TEMPLATES_DIR"   ] && mkdir -pv "$XDG_TEMPLATES_DIR"
[ -n "$XDG_VIDEOS_DIR"      ] && mkdir -pv "$XDG_VIDEOS_DIR"
echo "Done."
