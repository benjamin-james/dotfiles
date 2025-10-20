#!/bin/sh
_append_path()  { [ -d "$1" ] || return 0; case ":$PATH:" in *":$1:"*) ;; *) PATH="$PATH:$1";; esac; }
_prepend_path() { [ -d "$1" ] || return 0; case ":$PATH:" in *":$1:"*) ;; *) PATH="$1:$PATH";; esac; }
_is_interactive() { case $- in *i*) return 0;; esac; return 1; }
_have() { command -v "$1" >/dev/null 2>&1; }
_sourcedir() {
    dir="$1"
    [ -d "$dir" ] || return 0
    set -- "$dir"/*.sh
    [ -e "$1" ] || return 0
    for f do
	[ -r "$f" ] && . "$f"
    done
}
