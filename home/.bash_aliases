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
alias duo='du -hd 1 | gsort -h'
alias heroky=heroku
alias gst="git status"

