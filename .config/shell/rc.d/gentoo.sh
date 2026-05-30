#!/bin/sh
_is_interactive || return 0

startprefix() {
    if [ -z "${MY_EPREFIX:-}" ]; then
	echo "EPREFIX not found">&2
    else
	exec "${MY_EPREFIX}/startprefix"
    fi
}
