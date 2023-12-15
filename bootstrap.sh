#!/bin/sh

set -eu

if ! command -v stow; then
    echo 'ERROR: stow was not found in PATH'
    exit 1
fi

. ./shell.inc

mkdir -vp "$XDG_CACHE_HOME"
mkdir -vp "$XDG_CONFIG_HOME"
mkdir -vp "$XDG_DATA_HOME"
mkdir -vp "$XDG_STATE_HOME"
(
    cd ./stow
    stow -v ./*
)

echo "The bootstrap is done!"
echo "Don't forget to include this line in your shellrc:"
echo ". $(realpath ./shell.inc)"
