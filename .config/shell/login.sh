#!/bin/sh
if [ "${_DOT_LOGIN_SOURCED:-0}" -eq 1 ]; then
  return
fi
_DOT_LOGIN_SOURCED=1
_DOTBASE=${_DOTBASE:-"$HOME/.config/shell"}

[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"

_sourcedir "${_DOTBASE}"
_sourcedir "${_DOTBASE}/env.d"

OS=$(uname -s 2>/dev/null || echo unknown)
case "$OS" in
    Darwin) [ -r "${_DOTBASE}/os.d/darwin.sh" ] &&  . "${_DOTBASE}/os.d/darwin.sh" ;;
    Linux) [ -r "${_DOTBASE}/os.d/linux.sh" ] &&  . "${_DOTBASE}/os.d/linux.sh" ;;
esac

_sourcedir "${_DOTBASE}/host.d"
_sourcedir "${_DOTBASE}/prefix.d"

export PATH
