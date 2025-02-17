ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ] ;then
	mkdir -p $(dirname ZINIT_HOME)
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

export PATH=$PATH:/home/kabil/.local/bin
export EDITOR=/usr/bin/nvim

#https://github.com/0xTadash1/bat-into-tokyonight --> source 
export BAT_THEME="tokyonight_night"

export FZF_DEFAULT_OPTS="--color=bg+:#1a1b26,bg:#11121d,spinner:#ff6ac1,hl:#c0caf5,fg:#c0caf5,header:#ffcb6b,info:#9ece6a,pointer:#7aa2f7,marker:#ffb86c,fg+:#c0caf5,prompt:#ffb86c,hl+:#ff6ac1,border:#7aa2f7"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height=50% --preview-window=right:60%:wrap --layout=reverse --info=inline --border=rounded"


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
zinit light spaceship-prompt/spaceship-prompt
zinit light spaceship-prompt/spaceship-vi-mode
zinit ice wait"0" atload"source <(kubectl completion zsh)"


#alias
alias ls="eza --icons=always"
alias bat="bat --theme='Catppuccin Mocha'"
alias preview="bat --color always --theme='Catppuccin Mocha'"
alias search="fzf --preview 'bat --color always {}'"



#zoxide
eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd znav zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

