#!/bin/sh

if [ -z "${MY_EPREFIX:-}" ]; then
    for pfx in "$HOME/opt/gentoo" "$HOME/opt/prefix" "$HOME/opt/pfx"; do
	if [ -x "${pfx}/startprefix" ]; then
	    MY_EPREFIX="${pfx}"
	    export MY_EPREFIX
	    break
	fi
    done
fi
