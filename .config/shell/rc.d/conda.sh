#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
_is_interactive || return 0

if [ -n "${MY_CONDA_PREFIX:-}" ]; then
    _conda_init() {
	if [ -n "${BASH_VERSION:-}" ]; then
	    __conda_setup="$("${MY_CONDA_PREFIX}/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
	elif [ -n "${ZSH_VERSION:-}" ]; then
	    __conda_setup="$("${MY_CONDA_PREFIX}/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
	else
	    __conda_setup="$("${MY_CONDA_PREFIX}/bin/conda" 'shell.posix' 'hook' 2> /dev/null)"
	fi
	if [ $? -eq 0 ]; then
	    eval "$__conda_setup"
	else
	    if [ -f "${MY_CONDA_PREFIX}/etc/profile.d/conda.sh" ]; then
		. "${MY_CONDA_PREFIX}/etc/profile.d/conda.sh"
	    else
		_prepend_path "${MY_CONDA_PREFIX}/bin"
	    fi
	fi
	unset __conda_setup
    }
fi
