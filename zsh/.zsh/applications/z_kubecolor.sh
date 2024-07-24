#!/usr/bin/env bash
# vim:sw=2

if command -v kubectl &>/dev/null; then
  alias k='kubecolor'
  alias kubectl='kubecolor'
  compdef kubecolor=kubectl
  pathmunge "${HOME}/.krew/bin"
fi
