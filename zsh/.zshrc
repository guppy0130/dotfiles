#!/bin/zsh

# if oh-my-zsh isn't installed, install it
export ZSH="$HOME/.oh-my-zsh"
[ -d "$ZSH" ] || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc

# if fzf isn't installed, install it
[ -x "$(command -v fzf)" ] || (git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --no-key-bindings --no-completion --no-update-rc)

# ZSH specific configs
ZSH_THEME="clean"

plugins=(git docker docker-compose nvm fzf)

# shell things
source "$ZSH/oh-my-zsh.sh"
alias ls="ls -a --color=auto"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
