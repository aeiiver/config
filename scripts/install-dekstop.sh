set -e

yay -S - <pkglist-desktop.txt
bemoji -D all

echo "Done."
echo "Nothing was symlinked in your HOME. Do it yourself!"
