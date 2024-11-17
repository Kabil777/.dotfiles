ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ] ;then
	mkdir -p $(dirname ZINIT_HOME)
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

export PATH=$PATH:/home/kabil/.local/bin
export EDITOR=/usr/bin/nvim
source ~/.fzf.zsh
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.yaml)"

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

