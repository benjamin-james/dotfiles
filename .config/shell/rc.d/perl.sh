#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"

if [ -r "$HOME/perl5/perlbrew/etc/bashrc" ] && _have perlbrew; then
	if [ -n "${BASH_VERSION:-}" ]; then
		. "${HOME}/perl5/perlbrew/etc/bashrc"
	else
		printf "Warning: Perlbrew not initialized; not running Bash\n" >&2
	fi
fi
