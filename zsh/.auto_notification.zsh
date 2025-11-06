ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d $ZINIT_HOME ] ;then
	mkdir -p $(dirname ZINIT_HOME)
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

export PATH=$PATH:/home/kabil/.local/bin
export EDITOR=/usr/bin/nvim

export FZF_DEFAULT_OPTS="--color=bg+:#1a1b26,bg:#11121d,spinner:#ff6ac1,hl:#c0caf5,fg:#c0caf5,header:#ffcb6b,info:#9ece6a,pointer:#7aa2f7,marker:#ffb86c,fg+:#c0caf5,prompt:#ffb86c,hl+:#ff6ac1,border:#7aa2f7"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS 
  --no-border
  --preview-window=right:60%:wrap:border-sharp
  --no-scrollbar
  --layout=reverse-list
  --info=right
  --marker=' '              
  --pointer='▍'              
  "

#history
HISTFILE=~/.zsh_history
HISTDUP=erase
HISTSIZE=5000
SAVEHIST=5000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward

autoload -Uz compinit bashcompinit
compinit
bashcompinit

zinit light Aloxaf/fzf-tab
# zinit light chitoku-k/fzf-zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light hlissner/zsh-autopair
zinit light jeffreytse/zsh-vi-mode
zinit light paulirish/git-open
zinit light MichaelAquilina/zsh-auto-notify

zinit ice wait"0" atload"source <(kubectl completion zsh)"
zinit ice wait"0" atload"source <(kubeadm completion zsh)"
eval "$(starship init zsh)"
zinit ice lucid wait
zinit snippet OMZP::fzf
zstyle ':fzf-tab:*' use-fzf-default-opts yes

export ZVM_VI_HIGHLIGHT_BACKGROUND="#28344a"
export ZVM_VI_HIGHLIGHT_FOREGROUND="#a9b1d6"
export ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold

# env vars
export SDKMAN_DIR="$HOME/.sdkman"
export BAT_THEME="tokyonight_night"

#kubernetes alaias
alias k="kubectl"
alias kns="kubens"
alias kx="kubectx"
#alias
alias ls="eza --icons=always"
alias search="fzf --preview 'bat --color always {}'"
alias c="clear"
alias cat='bat --style=plain --paging=never'
git config --global core.pager "bat --paging=always"

#zoxide
eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd znav zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
alias swappy='GTK_THEME=WhiteSur-dark swappy'

# custom dunst notifications
[ -f ~/.auto_notification.zsh ] && source ~/.auto_notification.zsh

if (( $+commands[kubeadm] )); then
    ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}"
    # If the completion file does not exist, generate it and then source it
    # Otherwise, source it and regenerate in the background
    if [[ ! -f "$ZSH_CACHE_DIR/completions/_kubeadm" ]]; then
        mkdir -p "$ZSH_CACHE_DIR/completions"
        kubeadm completion zsh | tee "$ZSH_CACHE_DIR/completions/_kubeadm" >/dev/null
        source "$ZSH_CACHE_DIR/completions/_kubeadm"
    else
        source "$ZSH_CACHE_DIR/completions/_kubeadm"
        kubeadm completion zsh | tee "$ZSH_CACHE_DIR/completions/_kubeadm" >/dev/null &|
    fi
fi

#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

