#!/bin/bash

function notify() {
  USER_NAME="$USER"
  HOST_NAME="$(hostname)"
  DATE_STR="$(date '+%Y-%m-%d')"

  printf "<span font='JetBrainsMono Nerd Font 14' color='#9ece6a'><b>%s</b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#7aa2f7'><b>  Path: %s</b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#f7768e'> : <b><span color='#a9b1d6'>%s</span></b></span>  <span font='JetBrainsMono Nerd Font 12'      color='#7aa2f7'>󰒋 :<b><span color='#a9b1d6'>%s</span></b></span>  <span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>%s</span></b></span>\n" \
    "$1" "$2" "$USER_NAME" "$HOST_NAME" "$DATE_STR"

}
