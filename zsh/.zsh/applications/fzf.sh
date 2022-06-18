#!/usr/bin/env sh
# vim:tw=2:sw=2

# if fzf isn't installed, install it (and don't generate ~/.fzf.{bash,zsh} to keep $HOME clean)
[ -x "$(command -v fzf)" ] || (git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --no-key-bindings --no-completion --no-update-rc --bin)

pathmunge "$HOME/.fzf/bin"
