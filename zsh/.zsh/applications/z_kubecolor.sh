#!/usr/bin/env sh

alias k='kubecolor'
alias kubectl='kubecolor'
compdef kubecolor=kubectl

pathmunge "${HOME}/.krew/bin"
