#!/bin/zsh

# ZSH specific configs
ZSH_THEME="clean"

plugins=(git docker docker-compose nvm fzf)

# shell things
export ZSH="$HOME/.oh-my-zsh"
source "$ZSH/oh-my-zsh.sh"
alias ls="ls -a --color=auto"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
