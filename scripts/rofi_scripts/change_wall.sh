#!/bin/bash

rofi_dir="$HOME/.config/rofi"

image_dir="$HOME/.local/share/backgrounds/"
state_dir="$rofi_dir/state"
wall_list="$state_dir/wallpapers.txt"
current_file="$state_dir/current.txt"

current=$(rofi -dmenu -config "$rofi_dir"/config3.rasi -show drun -transient-window -p "Choose Wallpaper :" <"$wall_list")
echo "$image_dir/$current" >"$current_file"

swww img "$image_dir/$current" --transition-type=wipe --transition-fps=144 --transition-duration=4
