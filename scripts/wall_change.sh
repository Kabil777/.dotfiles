#!/usr/bin/bash
if ! pgrep -x "swww" >/dev/null 2>&1; then
	swww init
fi
wallpapers=(~/wall/*)
wallpaper="${wallpapers[RANDOM % ${#wallpapers[*]}]}"
swww img --transition-fps 60 --transition-step 3 --transition-duration 1.5 --transition-type left "$wallpaper"
echo "$wallpaper"
export WALL_PATH="$wallpaper"
wal -i "$wallpaper" -b "#1e1e2e" >/dev/null 2>&1

pkill waybar
waybar -c ~/.config/waybar/bak/config.jsonc -s ~/.config/waybar/bak/style.css
