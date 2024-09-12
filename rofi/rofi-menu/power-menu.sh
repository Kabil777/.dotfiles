#!/bin/sh 

shutdown='󰐥'
restart=''
lock='󰌾'
logout='󰗽'

chosen=$(echo -e "$shutdown\n$restart\n$lock\n$logout" | rofi -dmenu -theme ~/.config/rofi/rofi-menu/power-menu.rasi
) 
case $chosen in
  "$shutdown") sleep 2 && shutdown now ;;
  "$restart") sleep 2 &&  reboot;;
  "$lock") swaylock -C ~/.config/sway_lock/config && echo 'hi';;
  "$logout") pkill -KILL -u $USER;;
esac
