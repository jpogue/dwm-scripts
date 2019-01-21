#!/bin/sh
setxkbmap -layout us -variant mac &
/home/jstn/.fehbg &
compton &
xbanish &
xmodmap /home/jstn/.Xmodmap &
/home/jstn/.fehbg &
/home/jstn/.bin/status.sh &
while true; do
	dwm > /dev/null 2>&1
done
