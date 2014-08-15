#!/bin/bash

source /opt/boxen/env.sh

export EDITOR="vim"
export GIT_EDITOR='vim'
export CLICOLOR=1

unset MAILCHECK
export IRC_CLIENT='irssi'

# Save for later
# if [ `w | grep $LOGNAME | awk '{print $3}'` != "-" ]; then echo "remote"; fi
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

alias e='mvim --remote-tab-silent .'
alias edit='mvim '
alias gd='git diff | mvim'
alias gs='git status'

alias b="bundle"
alias bi="b check || b install --path vendor --binstubs bin"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

alias duo='du -rsh $(du -s * | sort -k1n | ruby -nae '\''puts '\$'F[1..-1].join("?")'\'')'

alias heroky=heroku
alias cwip="cucumber -p wip features/"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

hitch() {
  RBENV_VERSION=1.9.3-p125 command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]]; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='RBENV_VERSION=1.9.3-p125 hitch -u'

eval "$(hub alias -s)"

source ~/.git_bash_prompt
export PATH=./bin:/usr/local/heroku/bin:$PATH

