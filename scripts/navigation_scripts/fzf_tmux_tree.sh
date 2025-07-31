#!/bin/bash

# Theme colors using 2CYAN56-color codes (approx)
TREE_BRANCH_COLOR="\033[38;5;15m"
BLUE="\033[38;5;75m"
GREEN="\033[38;5;114m"
YELLOW="\033[38;5;179m"
MAGENTA="\033[38;5;141m"
TREE_REAL_BG="\033[38;5;103m"
CYAN="\033[38;5;117m"
RED="\033[38;5;1m"
GREY="\033[38;5;240m"
BOLD="\033[1m"
RESET="\033[0m"

function preview() {
  session=$1
  echo ""
  windows=$(tmux list-windows -t "$session" -F "#{window_index}:#{window_name}:#{window_active}:#{window_panes}")
  last_window_index=$(($(echo "$windows" | wc -l) - 1))

  echo -e "${BOLD}${BLUE}$session${RESET} (${YELLOW}${last_window_index}${RESET})"

  prefix="├──"
  branch="│   "

  i=0
  while IFS= read -r window; do
    window_name=$(echo "$window" | cut -d: -f2)
    is_active=$(echo "$window" | cut -d: -f3)
    window_index=$(echo "$window" | cut -d: -f1)
    no_of_panes=$(echo "$window" | cut -d: -f4)

    is_last_window=$([ "$last_window_index" -eq "$i" ] && echo true || echo false)
    active=$([ "$is_active" -eq 1 ] && echo "" || echo "")

    if [ "$is_last_window" == true ]; then
      prefix="└──"
      branch="    "
    fi

    echo -e "${TREE_REAL_BG}${prefix} ${GREEN}${window_name}${RESET} (${MAGENTA}󱂬 $no_of_panes${RESET})  $active"

    panes=$(tmux list-panes -t "$session:$window_index" -F "#{pane_current_command}:#{pane_current_path}:#{pane_active}")
    last_pane_index=$(($(echo "$panes" | wc -l) - 1))

    j=0
    while IFS= read -r pane; do
      pane_path=$(echo "$pane" | cut -d: -f2)
      pane_command=$(echo "$pane" | cut -d: -f1)
      active_plane=$(echo "$pane" | cut -d: -f3)

      is_last_pane=$([ "$last_pane_index" -eq "$j" ] && echo true || echo false)
      inner_tree="$branch ├──"
      if [ "$is_last_pane" == true ]; then
        inner_tree="$branch └──"
      fi

      is_pane_active=$([ "$active_plane" == 1 ] && echo "" || echo"")

      echo -e "${TREE_REAL_BG}${inner_tree} ${TREE_BRANCH_COLOR}${pane_path}${RESET} ${BG_PATH}${RED} $pane_command ${RESET} $is_pane_active"

      j=$((j + 1))
    done <<<"$panes"
    i=$((i + 1))
  done <<<"$windows"

}
export -f preview
preview "$1"
