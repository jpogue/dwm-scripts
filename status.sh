#!/usr/local/bin/bash

while true; do

	# get numbers for everyting
	
	BATTPERC="$(apm | grep -A 3 'Battery 0:' | grep life | grep -o '[0-9]\+')"
	DISK="[ $(df -h / | grep ROOT | grep -o '[0-9]\+%') ]"

       # set all of our icons, this only works with statuscolors patch installed
	if [ $BATTPERC -le 20 ]; then
		BATTICON="$(echo -ne '\x04') $(echo -ne '\ue24a')$(echo -ne '\x01') "
	else
		BATTICON="$(echo -ne '\ue24a')"
	fi

	DISKICON="$(echo -ne '\ue1e1')"
	CLOCKICON="$(echo -ne '\ue081')"
	CALICON="$(echo -ne '\ue225')"
	DWMICON="$(echo -ne '\ue241')"

   	# all the stuff we're gonna send to xsetroot
	TIME="[ $CLOCKICON$(date +%I:%M\ %p) ]"
	DATE="[ $CALICON$(date +%h\ %d) ]"
	BATT="[ $BATTICON$(apm | grep -A 3 'Battery 0:' | grep life | grep -o '[0-9]\+%') ]"
	DISK="[ $DISKICON$(df -h / | grep ROOT | grep -o '[0-9]\+%') ]"

	xsetroot -name "$DISK$BATT$DATE$TIME $DWMICON" 
	sleep 10
done
