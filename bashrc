#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#very useful ls aliases
alias ls='ls --color=auto'
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

PS1='[\u@\h \W]\$ '

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
export TERM=xterm-256color
export VISUAL=emacs
export EDITOR=$VISUAL
