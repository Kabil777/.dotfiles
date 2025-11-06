DATE_STR="$(date '+%Y-%m-%d')"

if [[ $1 == "high" ]]; then
    brightnessctl s +2%
    BRIGNTNESS=$(brightnessctl | grep "Current brightness" | awk '{print $3}')
fi

if [[ $1 == "low" ]]; then
    brightnessctl s 2%-
    BRIGNTNESS=$(brightnessctl | grep "Current brightness" | awk '{print $3}')
fi

dunstify -u low \
    -i "$HOME"/.config/dunst/icons/assets/invention-icon.svg \
    -h string:x-dunst-stack-tag:custominfo \
    " " \
    "<span font='CaskaydiaCove Nerd Font 14' color='#e0af68'><b><span color='#a9b1d6'>Brightness $BRIGNTNESS%</span></b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#9ece6a'><b> <span color='#a9b1d6'>System Manager</span></b></span>\n  <span font='JetBrainsMono Nerd Font 12' color='#bb9af7'><b>󱨩 <span color='#a9b1d6'>Dunst</span></b></span>\t<span font='JetBrainsMono Nerd Font 12' color='#ff9e64'>󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"
