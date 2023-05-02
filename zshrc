# prompt
setopt prompt_subst
NEWLINE=$'\n'
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f${NEWLINE}$ '

# history search with up/down
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# emacs shell support
if [[ "$TERM" == "dumb" ]]; then
    unset HISTFILE
    export PAGER=cat
    export TERM=xterm-color
    alias vim=""
fi
