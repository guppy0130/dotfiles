#!/usr/bin/env sh
# vim:sw=2

# always show (almost) everything (skip . and .. dirs)
alias ls="ls -A --color=auto"

# fix colors on WSL
# https://stackoverflow.com/a/61207429
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

# F: quit if one screen
# R: raw control chars (color)
# X: no init
# r: raw control chars (links)
export LESS="$LESS -FRXr"
