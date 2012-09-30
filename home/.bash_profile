#!/bin/bash

export EDITOR="vim"
export GIT_EDITOR='vim'

unset MAILCHECK
export IRC_CLIENT='irssi'

# Load cinderella
source $HOME/Developer/cinderella.profile
export PATH=./bin:$PATH

# Save for later
# if [ `w | grep $LOGNAME | awk '{print $3}'` != "-" ]; then echo "remote"; fi
alias droid="say 'droid' -v cellos"

export LESS="-R"
export HISTCONTROL=ignoreboth

# iTerm2 eating C-s
stty -ixoff
stty stop undef
stty start undef
