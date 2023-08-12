#!/bin/sh

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"

mkdir -pv "$XDG_CONFIG_HOME"/applications
ln -sv "$XDG_CONFIG_HOME"/mimeapps.list "$XDG_DATA_HOME"/applications/mimeapps.list
