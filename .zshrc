# vim: set ts=2 sw=2 sts=2 et:

export CLICOLOR=1

ZINIT_HOME=${HOME}/.zsh/zinit
source ${ZINIT_HOME}/zinit.zsh

zinit load agkozak/zsh-z
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit ice depth=1; zinit light romkatv/powerlevel10k
source ${HOME}/.p10k.zsh

autoload -U compinit && compinit

ZSHZ_CASE=smart
export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILE=${HOME}/.zsh_history
export HISTDUP=erase
setopt appendhistory
setopt hist_ignore_space

export EDITOR=nvim
export VISUAL=nvim

bindkey -e # Use emacs keybindings

# enables completion for "sub" commands, e.g. `git checkout <tab>`
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

alias dc="devcontainer"
alias dce="devcontainer exec --workspace-folder ./"
alias dcu="devcontainer up --workspace-folder ./"
alias gst="git status"
alias l="ls -lh"
alias ll="ls -lah"

if command -v ngrok &>/dev/null; then
	eval "$(ngrok completion)"
fi

export GPG_TTY=$(tty)
eval "$(fzf --zsh)"

fpath=(${ASDF_DIR}/completions $fpath)
. ${HOME}/.asdf/asdf.sh
