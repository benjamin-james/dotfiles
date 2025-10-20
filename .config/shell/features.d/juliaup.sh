#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
_prepend_path "$HOME/.juliaup/bin" 
_prepend_path "$HOME/.local/share/juliaup/bin"
