# Macports, if it's installed
if [ -d /opt ]; then
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=/opt/local/share/man:$MANPATH
fi

if [ -d /usr/local/mysql/bin/ ]; then
  export PATH=/usr/local/mysql/bin/:$PATH
fi

if [ -d /opt/local/lib/postgresql83/bin ]; then
  export PATH=/opt/local/lib/postgresql83/bin:$PATH
fi

export MAGICK_HOME=$HOME/src/ImageMagick-6.5.0
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib"
export PATH="$MAGICK_HOME/bin:/usr/sbin:$PATH"

# coreutils ls instead of OS X
if [[ "$TERM" != "dumb" && -f /opt/local/bin/ls ]]; then
  # Terminal colours (after installing GNU coreutils)
  NM="\[\033[0;38m\]" #means no background and white lines
  HI="\[\033[0;37m\]" #change this for letter colors
  HII="\[\033[0;31m\]" #change this for letter colors
  SI="\[\033[0;33m\]" #this is for the current directory
  IN="\[\033[0m\]"

  export LS_OPTIONS='--color=auto'
  eval `dircolors ~/.dir_colors`

  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;31m\]\w\[\033[00m\]\$ '
  alias du='du -h --max-depth=1'
else
  #PS1='\u@\h:\w\$ '
  
  parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
  }

  git_status() {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
  }
  
  # Colored
  export PS1='\[\e[1;32m\]\u \[\e[0m\]\w $(parse_git_branch)\[\e[0m\]\$ '

  alias du='du -h -d 1'
  export LS_OPTIONS='-G'
fi

export TERM=xterm-color

EDITOR=/usr/bin/vim; export EDITOR
SVN_EDITOR="$EDITOR --nofork"; export SVN_EDITOR

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export HISTCONTROL=ignoredups

# Aliases
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lah'
alias l='ls $LS_OPTIONS -lh'
alias df='df -h'

# Use bash completion, if it's available
if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
  . /usr/local/git/contrib/completion/git-completion.bash
fi

# don't require rubygems!
# http://gist.github.com/54177
RUBYOPT="rubygems"
export RUBYOPT
