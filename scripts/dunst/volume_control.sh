#!/usr/bin/env bash

USER_NAME="$USER"
HOST_NAME="$(hostname)"
DATE_STR="$(date '+%Y-%m-%d')"
ICON_PATH="/home/kabil/personal/scripts/dunst/assets/headphones-audio-svgrepo-com.svg"
IS_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]' && echo "yes" || echo "no")

if [[ $1 == "high" ]]; then
	if [[ $IS_MUTED == "no" ]]; then
		wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+
		VOLUME="Volume $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')%"
		ICON="$ICON_PATH/audio-high-round-svgrepo-com.svg"
	else
		VOLUME="MUTED"
		ICON="$ICON_PATH"
	fi
elif [[ $1 == "low" ]]; then
	if [[ $IS_MUTED == "no" ]]; then
		wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-
		VOLUME="Volume $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')%"
		ICON="$ICON_PATH"
	else
		VOLUME="MUTED"
		ICON="$ICON_PATH"
	fi
elif [[ $1 == "mute" ]]; then
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
	IS_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]' && echo "yes" || echo "no")

	if [[ $IS_MUTED == "yes" ]]; then
		VOLUME="MUTED"
		ICON="$ICON_PATH/audio-mute-round-svgrepo-com.svg"
	else
		VOLUME="UNMUTED"
		ICON="$ICON_PATH/audio-high-round-svgrepo-com.svg"
	fi
fi

dunstify -u low \
	-i $ICON_PATH \
	-h string:x-dunst-stack-tag:custominfo \
	" " \
	"<span font='JetBrainsMono Nerd Font 16' color='#e0af68'> <b><span color='#a9b1d6'>$VOLUME</span></b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#f7768e'> : <b><span color='#a9b1d6'>$USER_NAME</span></b></span>  <span font='JetBrainsMono Nerd Font 12'color='#7aa2f7' >󰒋 :<b><span color='#a9b1d6'>$HOST_NAME</span></b></span>  <span font='JetBrainsMono Nerd Font 12'color='#ff9e64' >󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"
