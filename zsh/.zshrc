ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d $ZINIT_HOME ] ;then
	mkdir -p $(dirname $ZINIT_HOME)
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

typeset -U path PATH
path=(
  "$HOME/.npm-global/bin"
  "$HOME/.cargo/bin"
  "$HOME/.local/bin"
  $path
)

export EDITOR=/usr/bin/nvim

export FZF_DEFAULT_OPTS="--color=bg+:#32302f,bg:#282828,spinner:#d3869b,hl:#cc241d,fg:#ebdbb2,header:#fabd2f,info:#98971a,pointer:#8ec07c,marker:#fe8019,fg+:#fbf1c7,prompt:#b8bb26,hl+:#fb4934,border:#665c54"

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
HISTSIZE=50000
SAVEHIST=50000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward

autoload -Uz compinit
if [[ -n "${HOME}/.zcompdump"(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-auto-notify
zinit light jeffreytse/zsh-vi-mode
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search
zinit ice lucid wait'0'
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice lucid wait'0'
zinit light hlissner/zsh-autopair
zinit ice lucid wait'0'
zinit light paulirish/git-open

eval "$(starship init zsh)"
zinit snippet OMZP::fzf
zstyle ':fzf-tab:*' use-fzf-default-opts yes

export ZVM_VI_HIGHLIGHT_BACKGROUND="#1e1e1e"
export ZVM_VI_HIGHLIGHT_FOREGROUND="#a9b1d6"
export ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold

# env vars
export SDKMAN_DIR="$HOME/.sdkman"
export BAT_THEME="gruvbox-dark"

#kubernetes alaias
alias k="kubectl"
alias kns="kubens"
alias kx="kubectx"
alias tf="terraform"
#alias
alias ls="eza --icons=always"
alias search="fzf --preview 'bat --color always {}'"
alias c="clear"
alias v="nvim"
alias lg="lazygit"
alias cz="nvim ~/.zshrc"
alias cat='bat --style=plain --paging=never'

#zoxide
eval "$(zoxide init zsh)"
alias znav="z"
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!tokyonight_night
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
alias swappy='GTK_THEME=WhiteSur-dark swappy'

# custom dunst notifications
[ -f ~/.auto_notification.zsh ] && source ~/.auto_notification.zsh
# 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


# Added by Antigravity CLI installer
export PATH="/home/kabil/.local/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
