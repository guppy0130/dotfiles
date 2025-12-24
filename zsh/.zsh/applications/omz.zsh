#!/usr/bin/env zsh
# vim:sw=2

# if oh-my-zsh isn't installed, install it
export ZSH="$HOME/.oh-my-zsh"
[ -d "$ZSH" ] || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
# omz custom dir
export ZSH_CUSTOM="$ZSH/custom"

# these are guaranteed to exist so add helpers
plugins=(git fzf ssh-agent dotenv)

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
# install_zsh_plugin "conda-zsh-completion" "https://github.com/esc/conda-zsh-completion"

# if command exists, add its plugin
[ -x "$(command -v docker)" ] && plugins+=(docker docker-compose)
[ -x "$(command -v nvm)" ] && plugins+=(nvm)
[ -x "$(command -v cargo)" ] && plugins+=(rust)
[ -x "$(command -v go)" ] && plugins+=(golang)
[ -x "$(command -v tmux)" ] && plugins+=(tmux)
[ -x "$(command -v terraform)" ] && plugins+=(terraform)
[ -x "$(command -v kubectl)" ] && plugins+=(kubectl)
[ -x "$(command -v gcloud)" ] && plugins+=(gcloud)

# configure the omz plugin options
zstyle :omz:plugins:ssh-agent agent-forwarding yes

# shell things
source "$ZSH/oh-my-zsh.sh"
