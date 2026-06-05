#!/bin/sh
_DOTBASE=${_DOTBASE:-"$HOME/.config/shell"}

[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"

### Re-export os.d functions for screen/tmux sessions
OS=$(uname -s 2>/dev/null || echo unknown)
case "$OS" in
Darwin) [ -r "${_DOTBASE}/os.d/darwin.sh" ] && . "${_DOTBASE}/os.d/darwin.sh" ;;
Linux) [ -r "${_DOTBASE}/os.d/linux.sh" ] && . "${_DOTBASE}/os.d/linux.sh" ;;
esac

_sourcedir "${_DOTBASE}/rc.d"

if [ -n "${STY:-}" ]; then
	export INSIDE_SCREEN=1
fi

if [ -n "${TMUX:-}" ]; then
	export INSIDE_TMUX=1
fi
