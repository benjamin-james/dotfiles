#!/bin/sh

dotgit() {
    if [ -n "${GIT_DIR:-}" ]; then
	echo "Please switch out of ${GIT_DIR}">&1
    else
	if [ -d "$HOME/.dotgit" ]; then
	    echo "asdfa"
	fi
    fi
}
