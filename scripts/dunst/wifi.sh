#!/bin/bash

# Get Wi-Fi interface
INTERFACE=$(nmcli -t -f DEVICE,TYPE device | grep ':wifi' | cut -d: -f1)
# Get current connection details
INFO=$(nmcli -t -f ACTIVE,SSID,SIGNAL,RATE dev wifi | grep '^yes' | cut -d: -f2-)

SSID=$(echo "$INFO" | cut -d: -f1)
SIGNAL=$(echo "$INFO" | cut -d: -f2)
RATE=$(echo "$INFO" | cut -d: -f3)

# Display with dunstify
dunstify -a "Wi-Fi Status" -u normal -r 2025 \
	-i network-wireless-signal-good \
	"📶 Connected to: $SSID" \
	"<span font='JetBrainsMono Nerd Font 12' color='#7aa2f7'>Signal Strength: <b>$SIGNAL%</b></span>\n<span font='JetBrainsMono Nerd Font 12' color='#a9b1d6'>Bitrate: <b>$RATE</b></span>"
