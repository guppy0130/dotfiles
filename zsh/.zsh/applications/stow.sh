#!/usr/bin/env sh
# vim:sw=2

# stow to homedir as expected (default is just parent dir, useless in WSL)
# if you have ~/dotfiles, this works as expected, of course
alias stow='stow -t $HOME'
