#!/usr/bin/bash 
if ! pgrep -x "swww" > /dev/null 2>&1; then
    swww init
fi

wallpapers=(~/.local/share/wallpapers-hyprland/*.*)
wallpaper="${wallpapers[RANDOM % ${#wallpapers[*]}]}"
swww img "$wallpaper" --transition-type=wipe --transition-duration=1.0
echo "$wallpaper"
export WALL_PATH="$wallpaper"

wal -i "$wallpaper" -b "#1e1e2e" > /dev/null 2>&1

pkill waybar 
waybar -c ~/.config/waybar/config.jsonc
