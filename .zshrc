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

cheat() {
  cat ~/cheatsheets/"$1" 2>/dev/null || echo "no cheatsheet for '$1'"
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
alias lf=lfcd

# tool initialization
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init zsh)"
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.4.1
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
. "$HOME/.local/bin/env"

[ -f "/Users/I587281/.ghcup/env" ] && . "/Users/I587281/.ghcup/env" # ghcup-env

# zoxide inline completion widget (Ctrl+Z)
_zoxide_fzf_widget() {
  local result
  zle autosuggest-clear
  result="$(zoxide query -l | fzf --reverse --height 40%)"
  LBUFFER+="${result}"
  zle autosuggest-fetch
  zle reset-prompt
}
zle -N _zoxide_fzf_widget
bindkey '^z' _zoxide_fzf_widget

# frecent files inline completion widget (Ctrl+F) — uses neovim oldfiles
_oldfiles_widget() {
  local result
  zle autosuggest-clear
  result="$(nvim --headless +'for f in v:oldfiles|if filereadable(f)|echo f|endif|endfor' +q 2>&1 | tr -d '\r' | fzf --reverse --height 40%)"
  LBUFFER+="${result}"
  zle autosuggest-fetch
  zle reset-prompt
}
zle -N _oldfiles_widget
bindkey '^f' _oldfiles_widget

# zoxide query function (outputs selected path, no cd)
zq() {
  zoxide query -l | fzf --reverse --height 40%
}

# fzf configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# ripgrep + fzf: search then filter
rfv() {
  rg --color=always --line-number --no-heading "${@:-}" |
    fzf --ansi --reverse --height 80% \
        --delimiter ':' \
        --preview 'bat --color=always --highlight-line {2} {1}' \
        --preview-window 'up,60%,+{2}-10'
}

# ripgrep + fzf: live interactive grep (like telescope live_grep)
rgi() {
  local result file line
  result=$(fzf --ansi --disabled \
    --bind "change:reload:rg --color=always --line-number --no-heading {q} || true" \
    --delimiter ':' \
    --preview 'bat --color=always --highlight-line {2} {1}' \
    --preview-window 'up,60%,+{2}-10' \
    --height 80% --reverse)

  file=$(echo "$result" | cut -d: -f1)
  line=$(echo "$result" | cut -d: -f2)
  [[ -n "$file" ]] && nvim "+$line" "$file"
}

# Local overrides (not tracked in dotfiles)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

