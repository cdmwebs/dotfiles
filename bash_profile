export TERM=xterm-color
EDITOR=/usr/bin/vim; export EDITOR
SVN_EDITOR="$EDITOR --nofork"; export SVN_EDITOR

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export HISTCONTROL=ignoredups

# don't require rubygems!
# http://gist.github.com/54177
export RUBYOPT="rubygems"

export PATH=~/bin:~/.gem/bin:/usr/local/pgsql/bin:$PATH
export GEM_HOME=~/.gem
export GEM_PATH=~/.gem:/usr/lib/ruby/gems/1.8:/Library/Ruby/Gems/1.8

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

git_status() {
	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

# Colored
export PS1='\[\e[1;32m\]\u \[\e[0m\]\w $(parse_git_branch)\[\e[0m\]\$ '

export LS_OPTIONS='-G'

# Aliases
alias ls='ls -hF $LS_OPTIONS'
alias ll='ls -lah $LS_OPTIONS'
alias l='ls -lh $LS_OPTIONS'
alias df='df -h'
alias du='du -h -d 1'

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
. /opt/local/etc/bash_completion
. /usr/local/git//contrib/completion/git-completion.bash

export S3_KEY="1NYJYNXDGW4KT4VB8PR2"
export S3_SECRET="qsH8fyBZLs+ZbsHJWPacxH18L/Zka2yxLTJXzZ0W"
export S3_BUCKET="bb-development"
