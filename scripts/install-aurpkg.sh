#!/bin/sh

set -e

if [ $# -ne 1 ]; then
	echo "usage: $0 <package>"
	exit 1
fi

package=$1
repo_url=https://aur.archlinux.org/"$package"

tmp_dir=$(mktemp -d aur.XXX)
trap 'rm -rf $tmp_dir' HUP QUIT ABRT TERM

(
	cd "$tmp_dir" || { echo "Failed to cd into $tmp_dir" && exit; }
	git clone --depth 1 "$repo_url" . >/dev/null 2>&1
	makepkg -sir --needed >/dev/null 2>&1 || { echo "'$package' doesn't seem to be a real package." && exit; }
	echo "Done."
)
rm -rf "$tmp_dir"
