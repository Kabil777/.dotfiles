#!/bin/bash

tmux list-sessions -F "#S" | fzf -i \
  --ansi \
  --layout=reverse-list \
  --no-border \
  --height=100% \
  --no-info \
  --info=inline-right:"Total Results : " \
  --prompt="Session Navigation :" \
  --preview='     bash -c "/home/kabil/personal/scripts/navigation_scripts/fzf_tmux_tree.sh {}"' \
  --preview-window=up:90%:wrap:border-bottom
