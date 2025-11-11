#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
MACPORTS_PREFIX=${MACPORTS_PREFIX:-/opt/local}

export TERM=xterm-256color

if ! command -v port >/dev/null 2>&1; then
  port() {
    local mp_port="$MACPORTS_PREFIX/bin/port"
    local mp_path="$MACPORTS_PREFIX/bin:$MACPORTS_PREFIX/sbin:$PATH"

    [ -x "$mp_port" ] || { printf >&2 'MacPorts not found at %s\n' "$MACPORTS_PREFIX"; return 127; }

    # If running as root, just exec with a temporary PATH
    if [ "$(id -u)" -eq 0 ]; then
      PATH="$mp_path" exec "$mp_port" "$@"
    fi

    # Heuristic: subcommands that usually require root
    case "${1-}" in
      install|uninstall|upgrade|activate|deactivate|sync|selfupdate|rev-upgrade|clean)
        # Use absolute paths + env to avoid sudo secure_path overriding PATH
        if command -v sudo >/dev/null 2>&1; then
          sudo /usr/bin/env PATH="$mp_path" "$mp_port" "$@"
        else
          # Fall back: try without sudo (may fail with perms)
          PATH="$mp_path" "$mp_port" "$@"
        fi
        ;;
      *)
        # Non-privileged actions (e.g., search, info, list)
        PATH="$mp_path" "$mp_port" "$@"
        ;;
    esac
  }
fi


