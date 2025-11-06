#!/bin/bash

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
        dunstify -i "$HOME"/.config/dunst/icons/assets/charging.jpg -u low \
            -h string:x-dunst-stack-tag:custominfo \
            -t 2000 \
            " " \
            "<span font='JetBrainsMono Nerd Font 14' color='#9ece6a'><b> Charger Connected</b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#9ece6a'><b> <span color='#a9b1d6'>System Manager</span></b></span>\n  <span font='JetBrainsMono Nerd Font 12' color='#bb9af7'><b>󱨩 <span color='#a9b1d6'>Dunst</span></b></span>\t<span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"

    elif [[ "$CURR_STATUS" == "discharging" ]]; then

        dunstify -i "$HOME"/.config/dunst/icons/assets/charging.jpg -u low \
            -h string:x-dunst-stack-tag:custominfo \
            -t 2000 \
            " " \
            "<span font='JetBrainsMono Nerd Font 14' color='#9ece6a'><b> Charger Disconnected</b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#9ece6a'><b> <span color='#a9b1d6'>System Manager</span></b></span>\n  <span font='JetBrainsMono Nerd Font 12' color='#bb9af7'><b>󱨩 <span color='#a9b1d6'>Dunst</span></b></span>\t<span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"
    fi
    echo "$CURR_STATUS" >"$PREV_STATUS_FILE"

fi
if [[ $1 == "get" ]]; then
    dunstify -i "$HOME"/.config/dunst/icons/assets/battery-thunder.png -u low \
        -h string:x-dunst-stack-tag:custominfo \
        -t 3000 \
        " " \
        "<span font='JetBrainsMono Nerd Font 14' color='#9ece6a'><b> Battery : <span color='#a9b1d6'>$CHARGE % [$STATUS]</span></b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#9ece6a'><b> <span color='#a9b1d6'>System Manager</span></b></span>\n  <span font='JetBrainsMono Nerd Font 12' color='#bb9af7'><b>󱨩 <span color='#a9b1d6'>Dunst</span></b></span>\t<span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"

    exit 0
fi
