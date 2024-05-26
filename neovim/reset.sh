#!/bin/sh

set -eu

rm -vrf "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim
rm -vrf "${XDG_STATE_HOME:-$HOME/.local/state}"/nvim
rm -vrf "${XDG_CACHE_HOME:-$HOME/.cache}"/nvim
rm -vf ./lazy-lock.json
