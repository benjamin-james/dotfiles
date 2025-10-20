#!/bin/sh

for pfx in "$HOME/opt/gentoo" "$HOME/opt/prefix" "$HOME/opt/pfx"; do
    if [ -x "${pfx}/startprefix" ]; then
	export MY_EPREFIX="${pfx}/startprefix"
	break
    fi
done

startprefix() {
    if [ -z "${MY_EPREFIX:-}" ]; then
	echo "EPREFIX not found">&2
    else
	exec "${MY_EPREFIX}/startprefix"
    fi
}
