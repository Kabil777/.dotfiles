#!/bin/bash

YAML_FILE="req.yaml"
TMP_JSON="/tmp/curl_payload.json"

# Get base info
name=$(yq '.curl[0].name' "$YAML_FILE")
method=$(yq '.curl[0].method' "$YAML_FILE")
url=$(yq '.curl[0].url' "$YAML_FILE")
headers=$(yq '.curl[0].headers[]' "$YAML_FILE")
options=$(yq '.curl[0].options[]' "$YAML_FILE")

# Prompt for data fields
data=$(yq '.curl[0].data' "$YAML_FILE")
json_body="{"
while IFS= read -r field; do
  key=$(cut -d ':' -f1 <<<"$field" | xargs)
  val=$(tmux popup -E -w 60 -h 10 -T "[ Enter $key ]" "read -p '$key: ' v; echo \$v")
  json_body+="\"$key\":\"$val\","
done < <(yq '.curl[0].data | to_entries[] | "\(.key):\(.value)"' "$YAML_FILE" | sed 's/"//g')

# Trim trailing comma
json_body="${json_body%,}}"

# Build curl flags
header_flags=""
for h in $headers; do
  header_flags+=" -H \"$h\""
done

# Choose options (optional)
chosen_opts=$(printf "%s\n" $options | fzf --multi --prompt="Select curl options: " --no-border)
opt_flags=$(echo "$chosen_opts" | awk '{ printf "%s ", $0 }')

# Execute curl
echo -e "\nExecuting:\n"
eval curl -X "$method" "$url" $opt_flags $header_flags -d "'$json_body'"
