#!/bin/sh

for file in "$XDG_CONFIG_HOME"/hypr/autostart/*; do
	"$file"
done
