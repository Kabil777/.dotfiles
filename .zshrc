ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ] ;then
	mkdir -p $(dirname ZINIT_HOME)
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

export PATH=$PATH:/home/kabil/.local/bin
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.yaml)"

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
#zinit light marlonrichert/zsh-autocomplete

#history
HISTFILE=~/.zsh_history
HISTDUP=erase
HISTSIZE=1000
setopt HIST_FIND_NO_DUPS
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey -v
#alias
alias list="eza --icons=always"
alias preview="bat --color always --theme='catppuccin mocha'"
alias search="fzf --preview="bat --color always ""
#alias yazi="$HOME/.config/yazi/target/release/yazi"
#zoxide
eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd znav zsh)"

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export EDITOR=/usr/bin/nvim
autoload -U compinit; compinit
