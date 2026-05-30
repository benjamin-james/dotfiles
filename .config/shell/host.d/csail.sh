#!/bin/sh
if [ "$HOME" = "/afs/csail.mit.edu/u/b/$USER" ]; then
	export MY_HOST="csail"
	export DATA_DIR="/data/scratch/$USER/"
	export MY_CONDA_DIR="${DATA_DIR}/miniconda3/"
	export UV_CACHE_DIR="${DATA_DIR}/uv-cache"
	export XDG_CACHE_HOME="${DATA_DIR}/.cache"
	ltmux() {
		if [ -z "${KRB5CCNAME:-}" ]; then
			printf '%s\n' 'tmux: KRB5CCNAME is not set; refusing to start longtmux' >&2
			return 1
		fi
		command longtmux -c "$KRB5CCNAME" "$@"
	}
	tmux() {
		case "${1:-}" in
		"")
			ltmux
			;;
		a | at | attach | attach-session | ls | list-sessions | list-windows | list-panes | kill-session | kill-server | detach-client | switch-client)
			command tmux "$@"
			;;
		new | new-session)
			printf '%s\n%s\n' \
				'Use ltmux -s NAME to start a persistent CSAIL tmux session.' \
				'Use command tmux new -s NAME only for an ordinary tmux session.' >&2
			return 2
			;;
		*)
			command tmux "$@"
			;;
		esac
	}
fi
