#!/bin/zsh

# if oh-my-zsh isn't installed, install it
export ZSH="$HOME/.oh-my-zsh"
[ -d "$ZSH" ] || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
# zsh custom dir
export ZSH_CUSTOM="$ZSH/custom"

# add fzf to $PATH so the next command works
# https://unix.stackexchange.com/a/217629
pathmunge() {
  if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)"; then
    if [ "$2" = "after" ]; then
      PATH="$PATH:$1"
    else
      PATH="$1:$PATH"
    fi
  fi
}
pathmunge "$HOME/.fzf/bin"
pathmunge "$HOME/.local/bin"

# if fzf isn't installed, install it (and don't generate ~/.fzf.{bash,zsh} to keep $HOME clean)
[ -x "$(command -v fzf)" ] || (git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --no-key-bindings --no-completion --no-update-rc --bin)

# ZSH specific configs

# these are guaranteed to exist so add helpers
plugins=(git fzf ssh-agent)

# helper fx to install plugin ($1) from git url ($2)
# then automatically add to plugins array
install_zsh_plugin() {
  # $1 is plugin name
  # $2 is git URL
  dest_dir="$ZSH_CUSTOM/plugins/$1"
  [ -d "$dest_dir" ] || (mkdir -p "$ZSH_CUSTOM/plugins" && git clone --depth 1 "$2" "$dest_dir")

  plugins+=("$1")
}
# if fzf-tab is not a directory/doesn't exist, clone it down
install_zsh_plugin "fzf-tab" "https://github.com/Aloxaf/fzf-tab"
install_zsh_plugin "conda-zsh-completion" "https://github.com/esc/conda-zsh-completion"

# if docker is installed, add to plugins
[ -x "$(command -v docker)" ] && plugins+=(docker docker-compose)
# if nvm add to plugins
[ -x "$(command -v nvm)" ] && plugins+=(nvm)

# shell things
source "$ZSH/oh-my-zsh.sh"
# always show (almost) everything (skip . and .. dirs)
alias ls="ls -A --color=auto"
# stow to homedir as expected (default is just parent dir, useless in WSL)
# if you have ~/dotfiles, this works as expected, of course
alias stow="stow -t $HOME"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# F: quit if one screen
# R: raw control chars (color)
# X: no init
export LESS="$LESS -FRX"

# fix colors on WSL
# https://stackoverflow.com/a/61207429
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

# use liquidprompt
[ -d "$HOME/liquidprompt" ] || git clone --depth 1 https://github.com/nojhan/liquidprompt.git
source "$HOME/liquidprompt/liquidprompt"
