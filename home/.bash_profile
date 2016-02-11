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
alias l='ls -lh'
alias ll='ls -lah'
alias q='exit'
alias reload='source $HOME/.bash_profile'

alias gd='git diff | mvim'
alias gs='git status'

alias b="bundle"
alias bi="b check || b install --path vendor --binstubs bin"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

alias duo='du -rsh $(du -s * | sort -k1n | ruby -nae '\''puts '\$'F[1..-1].join("?")'\'')'

alias heroky=heroku
alias gst="git status"

source ~/.git_bash_prompt

