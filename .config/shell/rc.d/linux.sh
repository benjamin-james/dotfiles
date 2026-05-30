#!/bin/sh
_is_interactive || return 0

gv() {
    nohup gwenview "$@" >/dev/null 2>/dev/null &
}
