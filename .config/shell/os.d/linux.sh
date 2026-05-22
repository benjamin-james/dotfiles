#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
_prepend_path "$HOME/.local/bin"
mkdir -p "${HOME}/.cache"
export KRB5CCNAME="DIR:${HOME}/.cache/krb5cc"
