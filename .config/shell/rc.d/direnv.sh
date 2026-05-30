#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
_have direnv || return 0
_is_interactive || return 0

if [ -n "${BASH_VERSION:-}" ]; then
    eval "$(direnv hook bash)"
elif [ -n "${ZSH_VERSION:-}" ]; then
    eval "$(direnv hook zsh)"
fi
