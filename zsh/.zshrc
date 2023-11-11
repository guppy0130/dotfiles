#!/bin/zsh
# vim:tw=2:sw=2

# source everything in aliases and functions
for f in ~/.zsh/{aliases,functions}/*.*sh; do
  source "$f"
done

# add ~/.local/bin to $PATH
pathmunge "$HOME/.local/bin"

# fixup keybindings
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# application scripts can use things from aliases and functions
for f in ~/.zsh/applications/*.*sh; do
  source "$f"
done

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export EDITOR=nvim
