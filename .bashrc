#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#only use ls --color=auto if available
if [[ $(ls --help | grep -e 'color=auto') ]]; then
    alias ls='ls --color=auto'
fi
alias ll='ls -alh'
alias la='ls -a'
alias l='ls -CFlh'
alias lsd='ls -alF | grep /$'

#find which files take the most space
alias diskspace='du -S | sort -n -r | less'

#instead of "foo | awk '{ print $2 }'"
#you can do "foo | fawk 2"
function fawk {
    first="awk '{ print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}
function make() {
	if [ "$1" = "love" ]; then
		echo "Segmentation fault (core dumped)" >&2
	else
		$(which make) $@
	fi
}
function gc() {
    git commit -m "$*"
}

alias ncmpcpp="ncmpcpp -c $HOME/.config/ncmpcpp/config"
alias enterprise="play -n -c1 synth whitenoise lowpass -1 120 lowpass -1 120 lowpass -1 120 gain +14"
alias soundsofhome="find ~ -type f -exec cat '{}' \; | play -r 44100 -b 16 -c 1 -e signed-integer -t raw - lowpass 4k flanger 0 7 reverb 100"
alias grep='grep --color=auto'
alias please='sudo $(history -p !!)'
alias kl='jobs | awk '"'"'BEGIN {cur="";}
/./ { last=cur ; cur=$0 ; }

END { if ( last != "")
{ print last ;} }'"'"' \
| tr -d '"'"'[]+-'"'"' \
| awk '"'"'{ print $1 }'"'"' \
| xargs -I __ echo kill %__'

reset=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
brown=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
bold=$(tput bold)

# Prompt coloring
if [[ "$(whoami)" == "root" ]]; then
    PS1='\[$red\]\u\[$blue\]@'
else
    PS1='\[$green\]\u\[$blue\]@'
fi
if [ -z $STY ]; then
    PS1=$PS1'\[$brown\]\h \[$blue\]\w \[$bold\]'
else
    PS1=$PS1'\[$brown\]$STY \[$blue\]\w \[$bold\]'
fi
if [[ "$(whoami)" == "root" ]]; then
    PS1=$PS1'\[$red\]\$ \[$reset\]'
else
    PS1=$PS1'\[$green\]\$ \[$reset\]'
fi

#large history is useful for "history | grep foo"
export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist #multi-liners as one
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

#pretty manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#use most, which is better than more or less
if [[ $(which most 2>/dev/null) ]]; then
    export PAGER="/usr/bin/most -s"
fi

export VISUAL="emacsclient -a ''"
export EDITOR=$VISUAL
GPG_TTY=$(tty)
export GPG_TTY

export spooky="1"
[ -f "$HOME/bin/spooky" ] && source $HOME/bin/spooky
