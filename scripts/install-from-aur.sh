#!/bin/sh

package=$1

tmp=$(mktemp -d aur.XXX)
trap 'rm -rf $tmp' HUP QUIT ABRT TERM

(
	cd "$tmp" || echo "Failed to cd into $tmp"
	git clone --depth 1 https://aur.archlinux.org/"$package" .
	makepkg -sir --needed
)
rm -rf "$tmp"

echo "Done."
