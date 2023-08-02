#!/bin/sh

pipe=/tmp/foot-scrollback-pipe

mkfifo $pipe 2>/dev/null
"$XDG_CONFIG_HOME"/hypr/scripts/scratchpad-it.sh \
    foot -T foot-scratchpad sh -c "nvim -Rm +'set laststatus=0' +'map <silent> q :qa!<CR>' <$pipe" &
cat /dev/stdin >$pipe
