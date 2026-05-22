#!/bin/sh

if [ -f "$HOME/perl5/perlbrew/etc/bashrc" ]; then
    if [ -n "$BASH_VERSION" ]; then
	source "$HOME/perl5/perlbrew/etc/bashrc"
    else
	echo "Warning: Perlbrew not initialized; not running Bash\n">&2
    fi
fi
