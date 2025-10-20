#!/bin/sh

if [ -z ${MY_EPREFIX:-} ]; then
    for pfx in "$HOME/opt/gentoo" "$HOME/opt/prefix" "$HOME/opt/pfx"; do
	if [ -x "${pfx}/startprefix" ]; then
	    MY_EPREFIX="${pfx}"
	    break
	fi
    done
fi

startprefix() {
    if [ -z "${MY_EPREFIX:-}" ]; then
	echo "EPREFIX not found">&2
    else
	exec "${MY_EPREFIX}/startprefix"
    fi
}
