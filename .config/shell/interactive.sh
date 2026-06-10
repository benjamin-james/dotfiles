#!/bin/sh
_DOTBASE=${_DOTBASE:-"$HOME/.config/shell"}

[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"

_sourcedir "${_DOTBASE}/rc.d"

if [ -n "${STY:-}" ]; then
	export INSIDE_SCREEN=1
fi

if [ -n "${TMUX:-}" ]; then
	export INSIDE_TMUX=1
fi
