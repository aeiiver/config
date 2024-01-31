#!/bin/sh

set -xue

rm -fr "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim
rm -fr "${XDG_STATE_HOME:-$HOME/.local/state}"/nvim
rm -fr "${XDG_CACHE_HOME:-$HOME/.cache}"/nvim
rm -r lazy-lock.json
