#!/bin/sh
_DOTBASE=${_DOTBASE:-"$HOME/.config/shell"}

[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"

_sourcedir "${_DOTBASE}/rc.d"

if [ -n "$STY" ]; then
    export INSIDE_SCREEN=1
fi

if [ -n "$TMUX" ]; then
    export INSIDE_TMUX=1
fi

if [ -z "${GIT_DIR:-}" ] && [ -d "$HOME/.dotgit/" ]; then
    alias gcfg="git --git-dir=$HOME/.dotgit --work-tree=$HOME"
fi
