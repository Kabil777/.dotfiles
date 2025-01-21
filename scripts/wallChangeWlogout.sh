#!/bin/bash
wallpaper="$1"

if [[ -z "$wallpaper" ]]; then
	echo "Error: No wallpaper name provided."
	echo "Usage: $0 <wallpaper_name_without_extension>"
	exit 1
fi

wallpaper_path="/home/kabil/wall/$wallpaper.png"
if [[ ! -f "$wallpaper_path" ]]; then
	echo "Error: Wallpaper file '$wallpaper_path' does not exist."
	exit 1
fi

killall hyprpaper 2>/dev/null

config_path="/home/kabil/.config/hypr/hyprpaper.conf"
printf "preload = %s\nwallpaper = ,%s\n" "$wallpaper_path" "$wallpaper_path" >"$config_path"

hyprpaper --config "$config_path" &
echo "Wallpaper set to '$wallpaper_path'."
