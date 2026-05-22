#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
MACPORTS_PREFIX=${MACPORTS_PREFIX:-/opt/local}
export TERM=xterm-256color
