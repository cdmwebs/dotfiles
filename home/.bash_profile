set -o vi

export TERM=xterm-color

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export HISTCONTROL=ignoredups
export LS_OPTIONS='-G'
[[ -s "$HOME/bin" ]] && export PATH=$HOME/bin:$PATH

# Git prompt
# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
#   username@Machine ~/dev/dir [master] $   # clean working directory
#   username@Machine ~/dev/dir [master*] $  # dirty working directory
# djmitche: *edit* an existing PS1 to add the git information
# djmitche: only invoke 'git' and 'sed' once (each) for each prompt
# djmitche: display [NO BRANCH] when not on a branch (e.g., during rebase -i)
# djmitche: almost completely replace with __git_ps1 from git contrib, which
#           gives more information and avoids calling git scripts if possible

# Based on:
#  http://repo.or.cz/w/git.git/blob/HEAD:/contrib/completion/git-completion.bash
# 
# Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
# Conceptually based on gitcompletion (http://gitweb.hawaga.org.uk/).
# Distributed under the GNU General Public License, version 2.0.

# __gitdir accepts 0 or 1 arguments (i.e., location)
# returns location of .git repo
__gitdir ()
{
    if [ -z "${1-}" ]; then
        if [ -n "${__git_dir-}" ]; then
            echo "$__git_dir"
        elif [ -d .git ]; then
            echo .git
        else
            git rev-parse --git-dir 2>/dev/null
        fi
    elif [ -d "$1/.git" ]; then
        echo "$1/.git"
    else
        echo "$1"
    fi
}

# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
# returns text to add to bash PS1 prompt (includes branch name)
__git_ps1 ()
{
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
        local r
        local b
        if [ -f "$g/rebase-merge/interactive" ]; then
            r="|REBASE-i"
            b="$(cat "$g/rebase-merge/head-name")"
        elif [ -d "$g/rebase-merge" ]; then
            r="|REBASE-m"
            b="$(cat "$g/rebase-merge/head-name")"
        else
            if [ -d "$g/rebase-apply" ]; then
                if [ -f "$g/rebase-apply/rebasing" ]; then
                    r="|REBASE"
                elif [ -f "$g/rebase-apply/applying" ]; then
                    r="|AM"
                else
                    r="|AM/REBASE"
                fi
            elif [ -f "$g/MERGE_HEAD" ]; then
                r="|MERGING"
            elif [ -f "$g/BISECT_LOG" ]; then
                r="|BISECTING"
            fi

            b="$(git symbolic-ref HEAD 2>/dev/null)" ||
            b="$(git name-rev --name-only HEAD  2> /dev/null)" ||
            b="unknown"
        fi

        local w
        local i
        local s
        local u
        local c

        if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
            if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
                c="BARE:"
            else
                b="GIT_DIR!"
            fi
        elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
            if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
                git diff --no-ext-diff --quiet --exit-code || w="⚡"
                if git rev-parse --quiet --verify HEAD >/dev/null; then
                    git diff-index --cached --quiet HEAD -- || i="+"
                else
                    i="#"
                fi
            fi
            if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
                    git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
            fi

            if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
               if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                  u="%"
               fi
            fi
        fi

        local f="$w$i$s$u"
        printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r"
    fi
}

# set up prefs
GIT_PS1_SHOWDIRTYSTATE=1

# prompt with git status
PS1="\[\e[1;32m\]\u@\h\[\e[0m\]:\w\[\e[33m\]\`__git_ps1\`\[\e[0m\]\\$ "

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -r $rvm_path/scripts/completion ]] && source $rvm_path/scripts/completion

# Any S3 keys?
[[ -s "$HOME/.s3_keys" ]] && . "$HOME/.s3_keys"

# Get and set the current heroku account
function hset() {
  ln -nfs ~/.heroku/credentials.$1 ~/.heroku/credentials
}

function hget() {
  readlink ~/.heroku/credentials | awk -F . '{print $NF}'
}

# OS specifics
os=$(uname)

if [[ "$os" = 'Linux' ]]; then
  export EDITOR=vim
elif [[ "$os" = 'Darwin' ]]; then
  export EDITOR=/usr/local/bin/mvim
  alias vim=/usr/local/bin/vim
  export PGDATA="/usr/local/var/postgres"
  [[ -f `brew --prefix`/etc/bash_completion ]] && . `brew --prefix`/etc/bash_completion
  [[ -s `brew --prefix`/bin/gls ]] && export LS_OPTIONS='--color=auto'
  export PATH=/usr/local/share/npm/bin:$PATH
fi

# Aliases
alias ls='ls -hF $LS_OPTIONS'
alias ll='ls -lah $LS_OPTIONS'
alias l='ls -lh $LS_OPTIONS'
alias df='df -h'
alias du='du -h -d 1'
alias ..='cd ..'
alias ...='cd ../..'

# Local Aliases
[[ -f $HOME/.bash_aliases ]] && source "$HOME/.bash_aliases"

export SVN_EDITOR="$EDITOR --nofork"
export GEM_EDITOR=$EDITOR
export CATALINA_HOME=/usr/local/apache-tomcat-6.0.29

# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

test -n "$INTERACTIVE" -a -n "$LOGIN" && {
    uname -npsr
    uptime
}


# --------------------------------------------------------------------
# MISC COMMANDS
# --------------------------------------------------------------------

# open an ssh tunnel
# tunnel user@host.name
tunnel () {
  ssh -D 8080 -f -C -q -N $1
}
