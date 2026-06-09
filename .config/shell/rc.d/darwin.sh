#!/bin/sh
_is_interactive || return 0
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
MACPORTS_PREFIX=${MACPORTS_PREFIX:-/opt/local}

if ! command -v port >/dev/null 2>&1; then
	port() {
		mp_port="$MACPORTS_PREFIX/bin/port"
		mp_path="$MACPORTS_PREFIX/bin:$MACPORTS_PREFIX/sbin:$PATH"

		[ -x "$mp_port" ] || {
			printf >&2 'MacPorts not found at %s\n' "$MACPORTS_PREFIX"
			return 127
		}

		if [ "$(id -u)" -eq 0 ]; then
			PATH="$mp_path" exec "$mp_port" "$@"
		fi

		case "${1-}" in
		install | uninstall | upgrade | activate | deactivate | sync | selfupdate | rev-upgrade | clean)
			if command -v sudo >/dev/null 2>&1; then
				sudo /usr/bin/env PATH="$mp_path" "$mp_port" "$@"
			else
				PATH="$mp_path" "$mp_port" "$@"
			fi
			;;
		*)
			PATH="$mp_path" "$mp_port" "$@"
			;;
		esac
		unset my_port
		unset mp_path
	}
fi

if _have otool && ! type -P ldd; then
	ldd() {
		### don't bother learning mac os x syntax
		if [ "$#" -eq 0 ]; then
			echo "Usage: ldd /path/to/binary" >&2
		else
			otool -L "$@"
		fi
	}
fi
