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

# Open link contained in file "link" with emacs's eww
alias eww='emacsclient -e "(eww \"`<link`\")"'

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

__git_ps1 () {
	local b="$(git symbolic-ref HEAD 2>/dev/null)";
	if [ -n "$b" ]; then
		printf " (%s) " "${b##refs/heads/}";
	fi
}
alias mute="amixer sset Master toggle"
alias ncmpcpp="ncmpcpp -c ~/.config/ncmpcpp/config"
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

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"


# This PS1 snippet was adopted from code for MAC/BSD I saw from: http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
# I tweaked it to work on UBUNTU 11.04 & 11.10 plus made it mo' better
# Prompt coloring

export PS1=$Yellow${STY:-'\h'}'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$IRed'"$(__git_ps1 " {%s}"); \
  fi) '$Blue$PathShort$Color_Off' "; \
else \
  # @2 - Prompt when not in GIT repo
  echo " '$Blue$PathShort$Color_Off' "; \
fi)'
if [[ "$(whoami)" == "root" ]]; then
    PS1=$Red'\u'$Blue'@'$PS1$BRed'\$ '$Color_Off
else
    PS1=$Green'\u'$Blue'@'$PS1$BGreen'\$ '$Color_Off
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
export GPG_TTY=$(tty)
export GTAGSLIBPATH="$HOME/.gtags"
export MPDCRON_DIR="/home/ben/.config/mpdcron"

export spooky="1"
[ -f "bin/spooky" ] && source bin/spooky
