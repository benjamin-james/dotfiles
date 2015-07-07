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
function gc() {
    git commit -m "$*"
}
alias grep='grep --color=auto'
alias emacsd='/usr/bin/emacs -nw'
alias emacs='/usr/bin/emacsclient -nw -a ""'
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
#Prompt coloring
if [[ "$?" != "0" ]]; then #if last command didn't return 0
    PS1='\[$brown\]\u\[$blue\]\w \[$bold\]\[$brown\]\$ \[$reset\]'
elif [[ "$(whoami)" == "root" ]]; then
    PS1='\[$red\]\u \[$blue\]\w \$[bold\]\[$red\]\$ \[$reset\]'
else
    PS1='\[$green\]\u \[$blue\]\w \[$bold\]\[$green\]\$ \[$reset\]'
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

if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xdefaults | \
		      awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
	echo -en "$i"
    done
    clear
fi
[[ "$PS1" ]] && echo -e "$brown $(fortune | cowsay) $reset"

export VISUAL=emacs
export EDITOR=$VISUAL
