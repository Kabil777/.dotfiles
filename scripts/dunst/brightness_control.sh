USER_NAME="$USER"
HOST_NAME="$(hostname)"
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
	-i /home/kabil/Downloads/brightness-weather-svgrepo-com.svg \
	-h string:x-dunst-stack-tag:custominfo \
	" " \
	"<span font='JetBrainsMono Nerd Font 16' color='#e0af68'>   <b><span color='#a9b1d6'>Brightness $BRIGNTNESS%</span></b></span>\n\n<span font='JetBrainsMono Nerd Font 12' color='#f7768e'> : <b><span color='#a9b1d6'>$USER_NAME</span></b></span>  <span font='JetBrainsMono Nerd Font 12'color='#7aa2f7' >󰒋 :<b><span color='#a9b1d6'>$HOST_NAME</span></b></span>  <span font='JetBrainsMono Nerd Font 12'color='#ff9e64' >󰃰 :<b><span color='#a9b1d6'>$DATE_STR</span></b></span>"
