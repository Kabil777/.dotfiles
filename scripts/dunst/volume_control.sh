#!/bin/bash

DATE_STR="$(date '+%Y-%m-%d')"
ICON_PATH=$HOME/.config/dunst/icons/assets/speaker-color-icon.svg
IS_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]' && echo "yes" || echo "no")

if [[ $1 == "high" ]]; then
    if [[ $IS_MUTED == "no" ]]; then
        wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+
        VOLUME="Volume $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')%"
    else
        VOLUME="MUTED"
    fi
elif [[ $1 == "low" ]]; then
    if [[ $IS_MUTED == "no" ]]; then
        wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-
        VOLUME="Volume $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')%"
    else
        VOLUME="MUTED"
    fi
elif [[ $1 == "mute" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    IS_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]' && echo "yes" || echo "no")

    if [[ $IS_MUTED == "yes" ]]; then
        VOLUME="MUTED"
    else
        VOLUME="UNMUTED"
    fi
fi

dunstify -u low \
    -i "$ICON_PATH" \
    -h string:x-dunst-stack-tag:custominfo \
    "" \
    "<span font='CaskaydiaCove Nerd Font 14' color='#e0af68'><b><span color='#a9b1d6'>$VOLUME</span></b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#9ece6a'><b> <span color='#a9b1d6'>System Manager</span></b></span>\n  <span font='JetBrainsMono Nerd Font 12' color='#bb9af7'><b>󱨩 <span color='#a9b1d6'>Dunst</span></b></span>\t<span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>\t"
