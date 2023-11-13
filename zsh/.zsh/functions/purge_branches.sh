#!/usr/bin/env bash

BRANCH_TMP_FILE="${TMPDIR:-/tmp/}merged-branches"

purge_branches() {
  default_branch="$(basename "$(git symbolic-ref refs/remotes/origin/HEAD)")"
  BRANCH="${1:-$default_branch}"

  # ones that are already merged
  git branch --merged "$BRANCH" | grep -v "$BRANCH" >"$BRANCH_TMP_FILE"
  # ones that are gone
  git branch --list --format "%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" | grep . >>"$BRANCH_TMP_FILE"

  # spawn editor only if there are branches to prune
  if [ -s "$BRANCH_TMP_FILE" ]; then
    ${EDITOR:-nvim} "$BRANCH_TMP_FILE"
    xargs git branch -D <"$BRANCH_TMP_FILE"
  else
    echo "no branches to purge"
  fi
}
