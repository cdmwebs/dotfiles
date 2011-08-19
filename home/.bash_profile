#!/bin/bash

export BASH=$HOME/.bash_it
export BASH_THEME='pete'

export EDITOR="/usr/local/bin/vim"
export GIT_EDITOR='/usr/local/bin/vim'

unset MAILCHECK
export IRC_CLIENT='irssi'

# Load Bash It
source $BASH/bash_it.sh

export PATH="./bin:$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
