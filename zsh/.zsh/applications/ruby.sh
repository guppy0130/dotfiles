#!/usr/bin/env sh
# vim:sw=2

if command -v gem &>/dev/null; then
  pathmunge "/opt/homebrew/opt/ruby/bin"
  pathmunge "$(gem environment gemdir)/bin"
fi
