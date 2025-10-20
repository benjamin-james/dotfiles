#!/bin/sh

if [ "${_DOT_MAIN_SOURCED-0}" -eq 1 ]; then
  return 0 2>/dev/null || exit 0
fi
_DOT_MAIN_SOURCED=1
_DOTBASE=${_DOTBASE:-"$HOME/.config/shell"}

[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"

_sourcedir "${_DOTBASE}"

OS=$(uname -s 2>/dev/null || echo unknown)
case "$OS" in
    Darwin) [ -r "${_DOTBASE}/os.d/darwin.sh" ] &&  . "${_DOTBASE}/os.d/darwin.sh" ;;
    Linux) [ -r "${_DOTBASE}/os.d/linux.sh" ] &&  . "${_DOTBASE}/os.d/linux.sh" ;;
esac

_sourcedir "${_DOTBASE}/host.d"
_sourcedir "${_DOTBASE}/prefix.d"
_sourcedir "${_DOTBASE}/features.d"

### todo: ssh create jump host dir

if [ -n "$STY" ]; then
    export INSIDE_SCREEN=1
fi

if [ -n "$TMUX" ]; then
    export INSIDE_TMUX=1
fi
   
if [ -z "${GIT_DIR:-}" ] && [ -d "$HOME/.dotgit/" ]; then
    alias gcfg="git --git-dir=$HOME/.dotgit --work-tree=$HOME"
fi
