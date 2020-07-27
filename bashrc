# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ignore commands beginning with a space
HISTCONTROL=ignorespace

# determine git branch
git_branch()
{
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

# setup bash prompt
case "$TERM" in
    xterm-color|*-256color) color_support=yes;;
esac

if [ "$color_support" == "yes" ]; then
    export PS1="\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[00;34m\]\w\[\033[00;35m\]\$(git_branch)\[\033[00m\]\n\$ "
else
    export PS1="\u@\h:\w\$(git_branch)\n\$ "
fi

unset color_support
