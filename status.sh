#!/usr/local/bin/bash
#called by startdwm.sh
#puts together a bunch of stuff and pushes it to the statusbar. Requires Siji font for icons and statuscolors for color

while true; do

	# get numbers for everyting
	
	BATTPERC="$(apm | grep -A 3 'Battery 0:' | grep life | grep -o '[0-9]\+')"
	DISK1="$(df -h /home | grep -o '[0-9]\+%' | sed s/%//g)"
	DISK2="$(df -h / | grep ROOT | grep -o '[0-9]\+%' | sed s/%//g)"
	DISKNUM=$((DISK1+DISK2))
	echo $DISK1
	echo $DISK2
	echo $DISKNUM

       # set all of our icons
	if [ $BATTPERC -le 20 ]; then
		BATTICON="$(echo -ne '\x03')$(echo -ne '\ue24a')$(echo -ne '\x01') "
	else
		BATTICON="$(echo -ne '\ue24a')"
	fi

	DISKICON="$(echo -ne '\ue147')"
	CLOCKICON="$(echo -ne '\ue081')"
	CALICON="$(echo -ne '\ue225')"
	DWMICON="$(echo -ne '\ue241')"

   	# all the stuff we're gonna send to xsetroot
	TIME=" $CLOCKICON$(date +%I:%M\ %p) "
	DATE=" $CALICON$(date +%h\ %d) "
	BATT=" $BATTICON$(apm | grep -A 3 'Battery 0:' | grep life | grep -o '[0-9]\+%') "
	DISK=" $DISKICON$DISKNUM% "

	xsetroot -name " [$DISK$BATT$DATE$TIME]" 
	sleep 10
done
