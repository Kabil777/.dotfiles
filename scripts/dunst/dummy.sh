#!/bin/bash

# Spotify Notification Script for Dunst
LOG_FILE="/tmp/spotify_notification.log"

log() {
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >>"$LOG_FILE"
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

trap "log 'Script terminated'; exit 0" SIGINT SIGTERM

last_track=""
PLayer() {
	while true; do
		log "Starting Spotify monitoring..."

		playerctl --player=$1 --follow metadata \
			--format "{{title}}|{{artist}}|{{album}}|{{mpris:artUrl}}|{{status}}|{{position}}|{{mpris:length}}" |
			while IFS="|" read -r title artist album icon_url status position; do

				[[ -z "$title" || "$status" == "Stopped" ]] && continue

				current_track="$title|$artist|$status"
				if [[ "$current_track" == "$last_track" ]]; then
					continue
				fi

				log "New track: $title by $artist [$status]"
				last_track="$current_track"

				# Album art handling
				icon_path="/tmp/spotify_album.jpg"
				if [[ -n "$icon_url" ]]; then
					curl -s -o "$icon_path" "$icon_url" || log "Failed to fetch album art"
				else
					icon_path="$HOME/.local/share/icons/WhiteSur-dark/apps/scalable/spotify.svg"
				fi

				# Notification
				dunstify -a "spotify" -i "$icon_path" \
					-r 777 -u low \
					-h string:x-dunst-stack-tag:spotify \
					" " \
					"<span font='JetBrainsMono Nerd Font 14' color='#7aa2f7'>󰎆 <span color='#a6adc8'><b>$title</b></span></span>
            
<span font='JetBrainsMono Nerd Font 12' color='#e0af68'> <span color='#a9b1d6'><b>$status</b></span></span>
<span font='JetBrainsMono Nerd Font 12' color='#f7768e'> <span color='#a9b1d6'><b>$artist</b></span></span>\t<span font='JetBrainsMono Nerd Font 12' color='#9ece6a'> <span color='#a9b1d6'><b>Spotify</b></span></span>"

			done

		log "Spotify stopped or disconnected. Retrying in 2s..."
		sleep 2
	done

}
PLayer spotify &
PLayer YoutubeMusic &
