#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
_prepend_path "/usr/local/go/bin"
if [ -d "$HOME/.local/share/go" ]; then
    GOPATH="$HOME/.local/share/go"
    export GOPATH
    _prepend_path "$GOPATH/bin"
fi

