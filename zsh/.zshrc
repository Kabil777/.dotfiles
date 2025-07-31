ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d $ZINIT_HOME ] ;then
	mkdir -p $(dirname ZINIT_HOME)
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

export PATH=$PATH:/home/kabil/.local/bin
export EDITOR=/usr/bin/nvim
# export KITTY_ENABLE_TMUX=1


#https://github.com/0xTadash1/bat-into-tokyonight --> source 
export BAT_THEME="tokyonight_night"

export FZF_DEFAULT_OPTS="--color=bg+:#1a1b26,bg:#11121d,spinner:#ff6ac1,hl:#c0caf5,fg:#c0caf5,header:#ffcb6b,info:#9ece6a,pointer:#7aa2f7,marker:#ffb86c,fg+:#c0caf5,prompt:#ffb86c,hl+:#ff6ac1,border:#7aa2f7"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS 
  --height=80%
  --border
  --preview-window=right:60%:wrap:border-sharp
  --no-scrollbar
  --layout=reverse
  --prompt='-> '             # Stylish prompt
  --marker='✓'              # Custom multi-select marker
  --pointer=''             # Custom pointer
  "

#history
HISTFILE=~/.zsh_history
HISTDUP=erase
HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey -v


autoload -Uz compinit
compinit
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice wait"0" atload"source <(kubectl completion zsh)"
zinit ice wait"0" atload"source <(kubeadm completion zsh)"
eval "$(starship init zsh)"


#kubernetes alaias
alias k="kubectl"
alias kns="kubens"
alias kx="kubectx"

#alias
alias ls="eza --icons=always"
alias bat="bat --theme='Catppuccin Mocha'"
alias preview="bat --color always --theme='Catppuccin Mocha'"
alias search="fzf --preview 'bat --color always {}'"
alias c="clear"



#zoxide
eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd znav zsh)"

export TERMINAL=kitty

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
alias swappy='GTK_THEME=WhiteSur-dark swappy'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


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
