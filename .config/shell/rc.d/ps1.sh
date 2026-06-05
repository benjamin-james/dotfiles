#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
_is_interactive || return 0

if _have tmux; then
	tmux_sock="${TMUX%%,*}"
	if [ -n "${TMUX:-}" ] && [ -S "${tmux_sock}" ] && tmux -S "${tmux_sock}" list-sessions >/dev/null 2>&1; then
		TMUX_TTY=$(tmux -S "${tmux_sock}" display-message -p '#{pane_tty}')
		TMUX_PTS=${TMUX_TTY##*/}
		TMUX_HOST=$(hostname -s)
		TMUX_STY="$(tmux -S ${tmux_sock} display-message -p '#S').${TMUX_PTS}.${TMUX_HOST}"
	else
		unset TMUX
	fi
	unset tmux_sock
fi
_session_label=$(hostname -s 2>/dev/null || hostname)
if [ -n "${STY:-}" ]; then
	_session_label="$STY"
elif [ -n "${TMUX_STY:-}" ]; then
	_session_label="$TMUX_STY"
fi

if _have tput; then
	_ncolor="$(tput colors 2>/dev/null)"
	if [ "${_ncolor:-0}" -ge 8 ]; then
		_ps1_green="$(tput setaf 2)"
		_ps1_blue="$(tput setaf 4)"
		_ps1_reset="$(tput sgr0)"
	fi
	unset _ncolor
fi

if [ -n "${BASH_VERSION:-}" ]; then
	if [ -n "${_ps1_green:-}" ]; then
		### also sets title
		PS1="\[\e]0;\u@${_session_label}: \w\a\]""\
${_ps1_green}\u@${_session_label}${_ps1_reset}:""\
${_ps1_blue}\w${_ps1_reset}\$ "
	else
		PS1="\u@${_session_label}:\w\$ "
	fi
fi
unset _ps1_green _ps1_blue _ps1_reset _session_label
