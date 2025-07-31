#!/bin/bash

ROOT_DIR=$HOME
print_with_z_tag() {
  local dir="$1"
  local label="$2"
  local term_width=$(tput cols)
  local label_length=${#label}
  local max_dir_width=$((term_width - label_length - 1))

  printf "%-${max_dir_width}s %s\n" "$dir" "$label"
}

function reload_dir_match() {

  zoxide query -l 2>/dev/null | while read -r dir; do
    [[ -d "$dir" ]] && print_with_z_tag "$dir" "[zoxde]"
  done

  fd --type d . "$ROOT_DIR" 2>/dev/null

}

export reload_dir_match
