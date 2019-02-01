#############################################################
#
# Puts together a bunch of stuff and echoes it.  
# Requires Siji font for icons and statuscolors for color
#
#############################################################

#!/usr/local/bin/bash

while true; do

	# get numbers for everything
	
	BATTPERC="$(apm | grep -A 3 'Battery 0:' | grep life | grep -o '[0-9]\+')"
	DISK1="$(df -h /home | grep -o '[0-9]\+%' | sed s/%//g)"
	DISK2="$(df -h / | grep ROOT | grep -o '[0-9]\+%' | sed s/%//g)"
	DISKNUM=$((DISK1+DISK2))

        # Battery icon red at < 20% and orange at < 50%, otherwise white
	if [ $BATTPERC -le 20 ]; then
		BATTICON="$(echo -ne '%{F#FF0000}')$(echo -ne '\ue24d')$(echo -ne '%{F#FFFFFF}') " 
	elif [ $BATTPERC -le 50 ]; then 
		BATTICON="$(echo -ne '%{F#ff950e}')$(echo -ne '\ue251')$(echo -ne '%{F#FFFFFF}') "
	else
		BATTICON="$(echo -ne '%{F#FFFFFF}')$(echo -ne '\ue254') "
	fi

	# Disk icon red at > 90% full and orange at > 60% full, otherwise white	
	if [ $DISKNUM -ge 90 ]; then
		DISKICON="$(echo -ne '%{F#FF0000}')$(echo -ne '\ue147')$(echo -ne '%{F#FFFFFF}') " 
	elif [ $DISKNUM -ge 60 ]; then 
		DISKICON="$(echo -ne '%{F#ff950e}')$(echo -ne '\ue147')$(echo -ne '%{F#FFFFFF}') "
	else
		DISKICON="$(echo -ne '%{F#FFFFFF}')$(echo -ne '\ue147') "
	fi

	CLOCKICON="$(echo -ne '\ue081')"
	CALICON="$(echo -ne '\ue225')"
	DWMICON="$(echo -ne '\ue241')"

   	# Consolidate all the stuff we're gonna send to xsetroot, not necessary but makes altering the final 'echo' command simpler
	TIME=" $CLOCKICON$(date +%I:%M\ %p) "
	DATE=" $CALICON$(date +%h\ %d) "
	BATT=" $BATTICON$(apm | grep -A 3 'Battery 0:' | grep life | grep -o '[0-9]\+%') "
	DISK=" $DISKICON$DISKNUM% "

	echo "%{c}[ $DISK $BATT $DATE $TIME ]"
	sleep 10
done
