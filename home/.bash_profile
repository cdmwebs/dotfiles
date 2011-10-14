#!/bin/bash

export BASH=$HOME/.bash-it
export BASH_THEME='cdmwebs'

export EDITOR="/usr/local/bin/vim"
export GIT_EDITOR='/usr/local/bin/vim'

unset MAILCHECK
export IRC_CLIENT='irssi'

# Load Bash It
source $BASH/bash_it.sh

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="./bin:$PATH"

# Save for later
# if [ `w | grep $LOGNAME | awk '{print $3}'` != "-" ]; then echo "remote"; fi
alias droid="say 'droid' -v cellos"

export LESS="-R"
export HISTCONTROL=ignoreboth
