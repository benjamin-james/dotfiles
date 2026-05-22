#!/bin/sh
_is_interactive || return 0

if hostname -s | grep -Fwq "luria"; then
    alias tmux="$HOME/bin/tmux"
fi
