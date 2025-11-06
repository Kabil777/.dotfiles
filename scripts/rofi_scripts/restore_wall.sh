#!/bin/bash

last_wall="$HOME/.config/rofi/state/current.txt"

if [[ -s "$last_wall" ]]; then
    swww img "$(cat "$last_wall")" --transition-type=wipe --transition-fps=144 --transition-duration=4
else
    swww img "$HOME/.local/share/backgrounds/Tokyo.png" --transition-type=wipe --transition-fps=144 --transition-duration=4
fi
