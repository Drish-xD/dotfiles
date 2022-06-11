#!/usr/bin/env bash

playerctl status &> /dev/null
if test $? -eq 1
then
	notify-send -t 700 -u normal "Player is not running" 
	exit
fi       



status="$(playerctl status -a | grep "Playing")"

ROFI="rofi -theme .scripts/Rofi/themes/player.rasi"

A='' B='' C='' 

if  $status ; then
    B=''
else
    B=''
fi

MENU="$(printf "${A}\n${B}\n${C}\n" | ${ROFI} -p "??" -dmenu -selected-row 1)"

case "$MENU" in
    "$A") playerctl previous -a

    ;;
    "$B") playerctl play-pause -a

    ;;
    "$C") playerctl next -a
esac 

exit ${?}
