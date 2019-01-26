#/bin/sh
#called from .xinitrc

setxkbmap -layout us -variant mac &
compton &
xbanish &
/home/jstn/.fehbg &
/home/jstn/.bin/status.sh &
xmodmap /home/jstn/.Xmodmap &

while true; do
	dwm > /dev/null 2>&1
done
