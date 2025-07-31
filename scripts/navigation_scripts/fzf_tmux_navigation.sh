#!/bin/bash

read -r input < <(printf "1 : for creating window\n2 : for creating pane" | fzf --print-query ...)

input=$(
  printf "1 : for creating window \n2 : for creating plane" | fzf --print-query --prompt="Enter name: " --height=10% \
    --no-border \
    --height=100% \
    --no-info \
    --prompt="Choose Option : "

)

input=$(echo "$input" | head -n1 | xargs)
echo "$input"
if [[ $? -ne 0 ]]; then
  exit 0
fi

dir=$(
  find "/home/$USER" -type d 2>/dev/null | fzf -i \
    --no-border \
    --height=100% \
    --no-info \
    --info=inline-right:"Total Resuts : " \
    --prompt="Choose Directory : "
)

if [[ -z "$dir" || ! -d "$dir" ]]; then
  notify-send "❌ Not a valid directory!"
  exit 1
fi

name=$(basename "$dir")
name=${name:-"new"}
name=${name// /_}

notify-send "$name  $input"
case "$input" in
1*)
  tmux new-window -c "$dir" -n "$name"
  ;;
2*)
  tmux split-window -v -c "$dir"
  ;;
esac
