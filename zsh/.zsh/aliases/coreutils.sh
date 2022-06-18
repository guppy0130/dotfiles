#!/usr/bin/env sh
# vim:tw=2:sw=2

# always show (almost) everything (skip . and .. dirs)
alias ls="ls -A --color=auto"

# fix colors on WSL
# https://stackoverflow.com/a/61207429
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

# F: quit if one screen
# R: raw control chars (color)
# X: no init
export LESS="$LESS -FRX"
