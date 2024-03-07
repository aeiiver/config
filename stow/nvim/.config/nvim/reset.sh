#!/bin/sh

set -xue

rm -rf "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim
rm -rf "${XDG_STATE_HOME:-$HOME/.local/state}"/nvim
rm -rf "${XDG_CACHE_HOME:-$HOME/.cache}"/nvim
rm -f lazy-lock.json
