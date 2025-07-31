#!/bin/bash
source /home/kabil/personal/scripts/navigation_scripts/notification_text.sh

dir_cache_file="/tmp/reload_file"

if [[ ! -e "$dir_cache_file" ]]; then
  touch "$dir_cache_file"
fi

COLOR_GREEN="\033[38;5;114m"
COLOR_RESET="\033[0m"

ROOT_DIR=$HOME
TERM_WIDTH=$(tput cols)
ZOXIDE_LABEL="[zoxide]"
LABEL_LENGTH=${#ZOXIDE_LABEL}
PADDING_OFFSET=5
MAX_DIR_WIDTH=$((TERM_WIDTH - LABEL_LENGTH - PADDING_OFFSET))

print_with_z_tag() {
  local dir="$1"
  local label="${2:-$ZOXIDE_LABEL}"

  printf "%-${MAX_DIR_WIDTH}s ${COLOR_GREEN}%s${COLOR_RESET}\n" "$dir" "$label"
}

function reload_dir_match() {

  zoxide query -l 2>/dev/null | awk -v max="$MAX_DIR_WIDTH" -v green="$COLOR_GREEN" -v reset="$COLOR_RESET" '
    BEGIN { OFS = "" }
    {
        printf "%-*s %s[zoxide]%s\n", max, $0, green, reset
    }
  '
  fd --type d . "$ROOT_DIR" 2>/dev/null

}

export reload_dir_match

function navigate() {
  reload_dir_match >"$dir_cache_file"
  dir=$(
    fzf -i \
      --ansi \
      --layout=default \
      --exact \
      --no-border \
      --height=100% \
      --no-info \
      --info=inline-right:"Total Results : " \
      --prompt="Choose Directory : " \
      --bind "change:reload(cat \"$dir_cache_file\"| rg --color=always --no-heading --fixed-strings {q} || true)" \
      --disabled <"$dir_cache_file"
  )
  dir=$(echo "$dir" | awk '{ print $1 }')
  if [[ -d "$dir" ]]; then
    zoxide add "$dir"
    tmux new-window -c "$dir" -n "$(basename "$dir")"
    dunstify -i /home/kabil/personal/scripts/navigation_scripts/tmux.png -u low \
      -h string:x-dunst-stack-tag:custominfo \
      -t 3000 \
      " " \
      "$(notify " Tmux Window created successfully !" "$dir")"

  else
    dunstify -i /home/kabil/personal/scripts/navigation_scripts/tmux.png -u low \
      -h string:x-dunst-stack-tag:custominfo \
      -t 3000 \
      " " \
      "$(notify "Failed to create a tmux window !" "invalid path")"

  fi
}

export navigate
navigate "$1"
