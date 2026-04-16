zmodload zsh/zprof

# completions
fpath=("/Users/I587281/.oh-my-zsh/custom/completions" $fpath)
autoload -Uz compinit
compinit

# powerlevel10k instant prompt, must stay near the top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
	vi-mode
	kubectl
	zsh-fzf-history-search
	npm
)

source $ZSH/oh-my-zsh.sh

# vi-mode
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export KEYTIMEOUT=1

# environment
export XDG_CONFIG_HOME=$HOME/.config
export VAULT_ADDR=https://vault.tools.sap
export KUBECONFIG=~/code/kubeconfigs/config
export SDKMAN_DIR="$HOME/.sdkman"
export WASMTIME_HOME="$HOME/.wasmtime"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export VISUAL="$EDITOR"

PATH=$PATH:~/Library/Python/3.9/bin
PATH=$PATH:~/go/bin
PATH=$PATH:~/bin
export PATH="$WASMTIME_HOME/bin:$PATH"

# shell options
setopt no_share_history
unsetopt share_history
unsetopt listambiguous

# keybindings
bindkey -M menuselect 'h' backward-char
bindkey -M menuselect 'k' up-line-or-history
bindkey -M menuselect 'l' forward-char
bindkey -M menuselect 'j' down-line-or-history
bindkey '^[[Z' autosuggest-accept
bindkey -s '^o' 'lfcd\n'

# functions
lfcd () {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")" || true
}

ff () {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

# aliases
alias caf='caffeinate -d'
alias uri='jq -sRr @uri'
alias nvm=fnm
alias vim=nvim
alias v=nvim
alias python=python3
alias vbox=VBoxManage
alias scim=sc-im
alias lg=lazygit
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}"'
alias branch='git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git switch'
alias dotfiles='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'

# tool initialization
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init zsh)"
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.4.1
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
. "$HOME/.local/bin/env"
