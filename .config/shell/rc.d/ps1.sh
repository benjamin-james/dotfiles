#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
_is_interactive || return 0

if _have tmux; then
    tmux_sock="${TMUX%%,*}"
    if [ -n "$TMUX" ] && [ -S "${tmux_sock}" ] && tmux -S "${tmux_sock}" list-sessions >/dev/null 2>&1; then
	TMUX_TTY=$(tmux -S "${tmux_sock}" display-message -p '#{pane_tty}')
	TMUX_PTS=${TMUX_TTY##*/}
	TMUX_HOST=$(hostname -s)
	TMUX_STY="$(tmux -S ${tmux_sock} display-message -p '#S').${TMUX_PTS}.${TMUX_HOST}"
    else
	unset TMUX
    fi
fi
_session_label=$(hostname -s 2>/dev/null || hostname)
if [ -n "$STY" ]; then
    _session_label="$STY"
elif [ -n "$TMUX_STY" ]; then
    _session_label="$TMUX_STY"
fi

if _have tput && [ "$(tput colors 2>/dev/null)" -ge 8 ]; then
  # Using tput inline; \[...\] protects nonprinting chars for bash
  PS1="\[\e]0;\u@${_session_label}: \w\a\]"\
"$(tput setaf 2)\u@${_session_label}$(tput sgr0):"\
"$(tput setaf 4)\w$(tput sgr0)\$ "
else
  PS1="\u@${_session_label}:\w\$ "
fi
