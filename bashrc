# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ignore commands beginning with a space
HISTCONTROL=ignorespace

# setup bash prompt
case "$TERM" in
    *-color|*-256color) color_support=yes;;
esac

if [ "$color_support" == "yes" ]; then
    export PS1="\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[00;34m\]\w\[\033[00m\]\n\$ "
else
    export PS1="\u@\h:\w\n\$ "
fi

unset color_support

# emacs shell support
if [[ "$TERM" == "dumb" ]]; then
    unset HISTFILE
    export PAGER=cat
    export TERM=xterm-color
    alias vim=""
fi
