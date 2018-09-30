#! /bin/bash

# exit if not running interactively
[[ $- != *i* ]] && return

# shell settings
shopt -s cdspell checkwinsize dotglob histappend
shopt -u mailwarn

# autocompletion
complete -cf sudo man
for i in /usr/local/etc/bash_completion.d/*; do source $i; done

# aliases to useful commands
alias ls="ls -aFG"      # list hidden files, file type, colorize, SI size units
alias ll="ls -lh"       # list in long format
alias le="ll -@e"       # list with extended attributes
alias mkdir="mkdir -p"  # create subdirectories if missing
alias df="df -h"        # use SI size units
alias grep="grep --color"   # colorize output
alias grp="grep -rni"       # grep recursively, show line number, ignore case
alias reload=". ~/.bashrc"  # reload bash settings
alias myip="curl icanhazip.com"         # shows IP address seen from outside
alias lsn="lsof -i -P | grep LISTEN"    # who is listening to which port
alias weather="curl http://wttr.in/"    # show the weather here

# useful bash functions
# calculator, supports floating point numbers and square root
calc() {
    echo "scale=4;$@" | bc -l
}

# git status and branch name in shell prompt
prompt_git() {
    local branch=`git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    [ -z "${branch}" ] && return

    local status=`git status 2>&1`
    local bits=" "

    echo $status | grep -q "modified:"                  && bits="${bits}!"
    echo $status | grep -q "renamed:"                   && bits="${bits}>"
    echo $status | grep -q "deleted:"                   && bits="${bits}x"
    echo $status | grep -q "new file:"                  && bits="${bits}+"
    echo $status | grep -q "Untracked files"            && bits="${bits}?"
    echo $status | grep -q "Your branch is ahead of"    && bits="${bits}*"

    [ "x${bits}" == "x " ] && bits=""
    printf "\001\e[01;36m\002[${branch}${bits}]\001\e[00m\002 "
}

# colorized manpages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Set terminal emulator window/tab title
case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|xterm-color|*-256color)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
esac

# ------ export variables start ------
set -a

# shell prompts
PS1='$(prompt_git)\[\e$([ $EUID == 0 ] && printf "[01;31m" || printf "[01;32m")\]\u@\H \[\e[01;34m\]\w \$\[\e[00m\] '
PS4="$LINENO + "

# colorize output
LSCOLORS="gxBxhxDxfxhxhxhxhxcxcx"
GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# maximum compression
GZIP="-9"
XZ_OPT="-9"

# set editor and pager
EDITOR="vim"
VISUAL=$EDITOR
PAGER="less"

# set paths
GOPATH="$HOME/Developer/golang"
PATH="/Applications/MacVim.app/Contents/bin:$GOPATH/bin:$PATH"

set +a
# ------ export variables finish ------
