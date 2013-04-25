#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

TERM="rxvt"

PS1='\[\e[1;37m\]\u\[\e[0;37m\]@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0;37m\]'

# alias ec="~/bin/edit"
export EDITOR="emacs -nw"

# colourful output
# grep
export GREP_COLOR="1;33"
alias grep='grep --color=auto'
# less
export LESS="-R"
# ls
alias ls='ls --color=auto'
# directories
eval $(dircolors -b)

export WORKON_HOME=~/dev/Envs
mkdir -p $WORKON_HOME
source /usr/bin/virtualenvwrapper.sh

source .bashrc_local
