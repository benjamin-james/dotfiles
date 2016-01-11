# gets the "active" tty
declare -rx active=$(</sys/class/tty/tty0/active)

[[ -d $HOME/go ]] && export GOPATH=$HOME/go
[[ -r $HOME/.bashrc ]] && source "$HOME"/.bashrc
[[ -d /sbin ]] && PATH=/sbin:$PATH
[[ -d /usr/sbin ]] && PATH=/usr/sbin:$PATH
[[ -d $HOME/bin ]] && PATH=$HOME/bin:$PATH
[[ -d $GOPATH/bin ]] && PATH=$GOPATH/bin:$PATH
[[ -r $HOME/.profile ]] && source "$HOME"/.profile

export XDG_CACHE_HOME=$HOME/.cache \
       XDG_CONFIG_HOME=$HOME/.config \
       XDG_DATA_HOME=$HOME/.local/share

# sets XDG_VTNR to the active tty number if not set
export XDG_VTNR=${XDG_VTNR:-${active#tty}}

# Setting GnuPG agent up
envfile="$HOME/.gnupg/gpg-agent.env"
if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
	eval "$(cat "$envfile")"
else
	eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
fi
export GPG_AGENT_INFO
export SSH_AUTH_INFO

# 'exec startx' makes sure that if x crashes or exits
# the user is logged out afterwards
[[ -z $DISPLAY && XDG_VTNR -eq 1 ]] && exec startx
