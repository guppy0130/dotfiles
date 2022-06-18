#!/usr/bin/env sh
# vim:tw=2:sw=2

# use liquidprompt
[ -d "$HOME/liquidprompt" ] || git clone --depth 1 https://github.com/nojhan/liquidprompt.git

#shellcheck source="~/liquidprompt/liquidprompt"
. "$HOME/liquidprompt/liquidprompt"
