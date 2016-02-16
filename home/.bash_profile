#!/bin/bash

if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export EDITOR="vim"
export GIT_EDITOR='vim'

unset MAILCHECK
export IRC_CLIENT='irssi'

alias droid="say 'droid' -v cellos"
alias server="ruby -run -e httpd -- -p 5000 ."
export LESS="-R"
export HISTCONTROL=ignoreboth

# iTerm2 eating C-s
stty -ixoff
stty stop undef
stty start undef

# Aliases
source ~/.bash_aliases
source ~/.git_bash_prompt

