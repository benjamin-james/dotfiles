#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
_have gpg-connect-agent || return 0
_have gpgconf || return 0

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket) || :
    export SSH_AUTH_SOCK
fi
if [ -t 1 ]; then
    GPG_TTY=$(tty)
    export GPG_TTY
    gpg-connect-agent updatestartuptty /bye >/dev/null
fi
