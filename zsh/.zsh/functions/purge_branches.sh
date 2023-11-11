#!/usr/bin/env bash

BRANCH_TMP_FILE="${TMPDIR:-/tmp/}merged-branches"

purge_branches() {
  BRANCH="${1:-main}"
  git branch --merged "$BRANCH" | grep -v "$BRANCH" >"$BRANCH_TMP_FILE" &&
    ${EDITOR:-nvim} "$BRANCH_TMP_FILE" && xargs git branch -d <"$BRANCH_TMP_FILE"
}
