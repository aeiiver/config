#!/bin/sh

dunst &
waybar &
nm-applet &
gammastep -P -t 3700:2700 -l 2:49 &
swaybg -m fill -i /home/na/data/visual/28981142_p0.jpg &
exec batsignal \
    -d 10 -D 'notify-send -u critical "Battery level is DANGER (<=10%)"' \
    -c 20 -C 'Battery level is CRITICAL (<=20%)' \
    -w 40 -W 'Battery level is low (<=40%)' \
    -f 75 -F 'Battery level is high (>=75%)' \
    -n BAT1
