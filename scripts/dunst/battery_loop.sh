#!/bin/bash

DATE_STR="$(date '+%Y-%m-%d')"
DIR="$HOME/.config/hypr"

echo "$DIR/hyprland.conf"
BAT_STATUS="/sys/class/power_supply/BAT0/status"
BAT_CAPACITY="/sys/class/power_supply/BAT0/capacity"
ALERT_FILE="/tmp/.battery_alert_sent"
ALERT_FILE_10="/tmp/.battery_alert_10"
# Monitor both status and capacity
while true; do
    CHARGE=$(<"$BAT_CAPACITY")
    STATUS=$(<"$BAT_STATUS")

    if [[ $CHARGE -le 20 && "$STATUS" == "Discharging" ]]; then
        if [[ ! -f "$ALERT_FILE" ]]; then
            dunstify -u low \
                -h string:x-dunst-stack-tag:custominfo \
                -t 6000 \
                " " \
                "<span font='JetBrainsMono Nerd Font 14' color='#f7768e'><b>  Battery : <span color='#a9b1d6'>$CHARGE % [$STATUS]</span></b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#9ece6a'><b> <span color='#a9b1d6'>System Manager</span></b></span>\n  <span font='JetBrainsMono Nerd Font 12' color='#bb9af7'><b>󱨩 <span color='#a9b1d6'>Dunst</span></b></span>\t<span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"
            touch "$ALERT_FILE"
        fi
    else
        [[ -f "$ALERT_FILE" ]] && rm "$ALERT_FILE"
    fi

    if [[ $CHARGE -le 10 && "$STATUS" == "Discharging" ]]; then
        if [[ ! -f "$ALERT_FILE_10" ]]; then
            dunstify -i -u low \
                -h string:x-dunst-stack-tag:custominfo \
                -t 6000 \
                " " \
                "<span font='JetBrainsMono Nerd Font 14' color='#f7768e'><b>  Battery : <span color='#a9b1d6'>$CHARGE % [$STATUS]</span></b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#9ece6a'><b> <span color='#a9b1d6'>System Manager</span></b></span>\n  <span font='JetBrainsMono Nerd Font 12' color='#bb9af7'><b>󱨩 <span color='#a9b1d6'>Dunst</span></b></span>\t<span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"
            touch "$ALERT_FILE_10"
        fi
    else
        [[ -f "$ALERT_FILE_10" ]] && rm "$ALERT_FILE_10"
    fi

    inotifywait -e modify "$BAT_STATUS" -t 2 >/dev/null 2>&1
    ~/personal/scripts/dunst/battery_control.sh

done
