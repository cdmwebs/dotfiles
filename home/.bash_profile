#!/bin/bash

export EDITOR="vim"
export GIT_EDITOR='vim'
export CLICOLOR=1

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

# Aliases
alias l='ls -lh'
alias ll='ls -lah'
alias q='exit'
alias reload='source $HOME/.bash_profile'

alias e='mvim . &'
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

[[ -f `brew --prefix`/etc/bash_completion ]] && . `brew --prefix`/etc/bash_completion

hitch() {
  RBENV_VERSION=1.9.2-p290 command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]]; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='RBENV_VERSION=1.9.2-p290 hitch -u'

# Uncomment to persist pair info between terminal instances
# hitch

# COLORS
LIGHT_GRAY="\[\033[0;37m\]"
BLUE="\[\033[1;36m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
YELLOW="\[\033[1;33m\]"

# GIT PROMPT (http://gist.github.com/120804)
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \(\1\)/';
}
function parse_git_status {
  git status 2> /dev/null | sed -e '/(working directory clean)$/!d' | wc -l;
}
function check_git_changes {
  # tput setaf 1 = RED, tput setaf 2 = GREEN
  [ `parse_git_status` -ne 1 ] && tput setaf 1 || tput setaf 2
}

export PS1="\w\[\$(check_git_changes)\]\$(parse_git_branch)$LIGHT_GRAY $ "
