#!/bin/sh

mkdir -pv "${XDG_DATA_HOME:-$HOME/.local/share}"/applications
ln -sv "${XDG_CONFIG_HOME:-$HOME/.config}"/mimeapps.list "${XDG_DATA_HOME:-$HOME/.local/share}"/applications/mimeapps.list
