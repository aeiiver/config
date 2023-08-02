#!/bin/sh

exec batsignal \
	-d 15 -D 'notify-send -u critical "Battery level is DANGER (<=15%)"' \
	-c 25 -C 'Battery level is CRITICAL (<=25%)' \
	-w 40 -W 'Battery level is low (<=40%)' \
	-f 75 -F 'Battery level is high (>=75%)' \
	-n BAT1
