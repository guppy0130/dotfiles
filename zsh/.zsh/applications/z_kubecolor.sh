#!/usr/bin/env sh

alias k='kubecolor'
alias kubectl='kubecolor'

if command -v kubectl &>/dev/null; then
  compdef kubecolor=kubectl
  pathmunge "${HOME}/.krew/bin"
fi
