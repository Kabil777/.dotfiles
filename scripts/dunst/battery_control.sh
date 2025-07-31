#!/bin/bash

USER_NAME="$USER"
HOST_NAME="$(hostname)"
DATE_STR="$(date '+%Y-%m-%d')"

BAT="/sys/class/power_supply/BAT0"
CHARGE=$(cat $BAT/capacity)
STATUS=$(cat $BAT/status)
CURR_STATUS="$(echo "$STATUS" | tr '[:upper:]' '[:lower:]')"

PREV_STATUS_FILE="/tmp/.battery_status_prev"

if [[ ! -f "$PREV_STATUS_FILE" ]]; then
  echo "$CURR_STATUS" >"$PREV_STATUS_FILE"
fi
LAST_STATUS=$(cat "$PREV_STATUS_FILE")

if [[ "$LAST_STATUS" != "$CURR_STATUS" ]]; then
  if [[ "$CURR_STATUS" == "charging" ]]; then
    dunstify -i /home/kabil/personal/scripts/dunst/assets/charging.jpg -u low \
      -h string:x-dunst-stack-tag:custominfo \
      -t 2000 \
      " " \
      "<span font='JetBrainsMono Nerd Font 14' color='#9ece6a'><b> Charger Connected</b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#f7768e'> : <b><span color='#a9b1d6'>$USER_NAME</span></b></span>  <span font='JetBrainsMono Nerd Font 12' color='#7aa2f7'>󰒋 :<b><span color='#a9b1d6'>$HOST_NAME</span></b></span>  <span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"

  elif [[ "$CURR_STATUS" == "discharging" ]]; then

    dunstify -i /home/kabil/personal/scripts/dunst/assets/charging.jpg -u low \
      -h string:x-dunst-stack-tag:custominfo \
      -t 2000 \
      " " \
      "<span font='JetBrainsMono Nerd Font 14' color='#9ece6a'><b> Charger Disconnected</b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#f7768e'> : <b><span color='#a9b1d6'>$USER_NAME</span></b></span>  <span font='JetBrainsMono Nerd Font 12' color='#7aa2f7'>󰒋 :<b><span color='#a9b1d6'>$HOST_NAME</span></b></span>  <span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"
  fi
  echo "$CURR_STATUS" >"$PREV_STATUS_FILE"

fi
if [[ $1 == "get" ]]; then
  dunstify -i /home/kabil/personal/scripts/dunst/assets/battery-svgrepo-com.svg -u low \
    -h string:x-dunst-stack-tag:custominfo \
    -t 3000 \
    " " \
    "<span font='JetBrainsMono Nerd Font 14' color='#9ece6a'><b> Battery : <span color='#a9b1d6'>$CHARGE % [$STATUS]</span></b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#f7768e'> : <b><span color='#a9b1d6'>$USER_NAME</span></b></span>  <span font='JetBrainsMono Nerd Font 12' color='#7aa2f7'>󰒋 :<b><span color='#a9b1d6'>$HOST_NAME</span></b></span>  <span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"
  exit 0
fi
