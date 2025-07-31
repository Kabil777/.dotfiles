#!/bin/bash
COLOR="\033[38;5;114m"
RESET="\033[0m"

FIGLET_TEXT="Tmux Telescope"
FIGLET=$(figlet -f slant "$FIGLET_TEXT")
WIDTH=$(tput cols)
CENTERED+=$(echo "$FIGLET" | while IFS= read -r line; do
  pad=$(((WIDTH - ${#line}) / 2))
  printf "%*s\n" $((pad + ${#line})) "$line"
done)

function option() {
  printf "Tmux Session Tree\nCustom Window Launcher" | fzf --ansi \
    --layout=reverse \
    --prompt="" \
    --preview="echo '$COLOR$CENTERED$RESET'" \
    --preview-window=up:30%:wrap:border-none \
    --no-info \
    --height=100% \
    --border=none \
    --info=inline-right:"Total Plugins : " \
    --prompt="Choose Plugins :"
}
choosen=$(option)
case "$choosen" in
"Tmux Session Tree")
  script -c "$HOME/personal/scripts/navigation_scripts/test.sh"
  ;;
"Custom Window Launcher")
  script -c "$HOME/personal/scripts/navigation_scripts/fzf_tmux_window_navigation.sh"
  ;;
"*")
  echo "Invalid option"
  ;;
esac

read -r
