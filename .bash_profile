declare -rx active=$(</sys/class/tty/tty0/active)

[[ -r $HOME/.bashrc ]] && source "$HOME"/.bashrc
[[ -d $HOME/bin ]] && PATH=$HOME/bin:$PATH

export XDG_CACHE_HOME=$HOME/.cache \
       XDG_CONFIG_HOME=$HOME/.config \
       XDG_DATA_HOME=$HOME/.local/share

export XDG_VTNR=${XDG_VTNR:-${active#tty}}

[[ -z $DISPLAY && XDG_VTNR -eq 1 ]] && startx

eval $(ssh-agent)
