#!/bin/sh
_is_interactive || return 0

gv() {
	if [ "$#" -eq 0 ]; then
		exec gwenview --help
	else
		gtk-launch gwenview "$@" >/dev/null 2>/dev/null
	fi
}

oku() {
	if [ "$#" -eq 0 ]; then
		exec okular --help
	else
		gtk-launch okular "$@" >/dev/null 2>/dev/null
	fi
}
