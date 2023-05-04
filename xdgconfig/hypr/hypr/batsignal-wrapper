#!/bin/sh

exec batsignal \
    -d 10 -D 'notify-send -u critical "Battery level is DANGER (<=10%)"' \
    -c 20 -C 'Battery level is CRITICAL (<=20%)' \
    -w 40 -W 'Battery level is low (<=40%)' \
    -f 75 -F 'Battery level is high (>=75%)' \
    -n BAT1
