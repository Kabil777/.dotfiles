#!/bin/bash

source_dir="$HOME/.dotfiles/rofi/backgrounds"
image_dir="$HOME/.local/share/backgrounds"
rofi_img_dir="$HOME/.config/rofi"

wall_list="$rofi_img_dir/state/wallpapers.txt"
bold=$(tput bold)
dim=$(tput dim)
reset=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)

out() {
    local type=$1
    shift
    local content="$1"
    shift
    local msg="$*"

    case "$type" in
    section)
        printf "\n${bold}${blue} %s${reset}: %s\n" "$content" "$msg"
        ;;
    info)
        printf "${dim}• %s${reset}: %s\n" "$content" "$msg"
        ;;
    success)
        printf "${green} %s${reset}: %s\n" "$content" "$msg"
        ;;
    warn)
        printf "${yellow} %s${reset}: %s\n" "$content" "$msg"
        ;;
    error)
        printf "${red} %s${reset}: %s\n" "$content" "$msg"
        ;;
    done)
        printf "\n${blue} Done${reset}\n"
        ;;
    *)
        printf "%s" "$msg"
        ;;
    esac
}

if ! command -v magick &>/dev/null; then
    out error "ImageMagick not found" "Please install ImageMagick to generate thumbnails"
    exit 1
fi
out section "Wallpaper Setup"

for dir in "$rofi_img_dir/images" "$rofi_img_dir/images/wall_icons" "$rofi_img_dir/state" $image_dir; do
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        out info "Created directory" "$dir"
    fi
done

if [[ -f $wall_list ]]; then
    rm -rf "$wall_list"
    out info "Deleted" "existing $(basename "$wall_list")"
fi

out info "copying from" "$source_dir"
images=$(find "$source_dir" -type f -iname '*.jpg' -o -iname '*.png' | sort)

count=0
total=$(echo "$images" | wc -l)

for img in $images; do
    ((count++))
    cp "$img" "$image_dir"
    out success "copied($count/$total)" "$(basename "$img")"

    icon_path="$rofi_img_dir/images/wall_icons/$(basename "$img")"

    if magick "$img" -thumbnail 400x225^ -gravity center -extent 400x225 -quality 80 "$icon_path" 2>/dev/null; then
        out success "created icon" "$(basename "$img") at $(basename "$icon_path")"
    else
        out error "failed to create icon" "$(basename "$img") — check if file is valid or not supported"
    fi

done

: >"$wall_list" # clear existing

for img in "$rofi_img_dir/images/wall_icons/"*; do
    echo -en "$(basename "$img")\x00icon\x1f$img\n" >>"$wall_list"
done

out success "Wallpapers generated at" "$icon_path"
out success "Wallpaper icons  generated at" "$rofi_img_dir"
out success "Wallpaper list generated at" "$wall_list"

out "done"
