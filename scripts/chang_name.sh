#!/bin/bash
dir='.'
count=1
for file in "$dir"/*.* ;do
  if [ -e  "$file" ];then
    extension="${file##*.}"
    mv "$file" "$dir/$count.$extension"
    ((count++))
  fi
done
