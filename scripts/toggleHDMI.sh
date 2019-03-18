#!/bin/bash

intern=LVDS1
extern=HDMI1

case $1 in 

"-h")
	MODE="hdmi"
	;;
"-n")
	MODE="normal"
	;;
esac

case $MODE in
"hdmi")
if xrandr | grep "$extern connected"; then
	xrandr --output "$intern" --off --output "$extern" --auto  
#	sed -i '8s/.*/pcm "hw:0,3" #SoundIs HDMI/' ~/.asoundrc
		pacmd set-card-profile 0 output:hdmi-stereo
		pulseaudio -k
		sleep 1s
	       	pulseaudio --start
		bspc monitor $intern -r 
		bspc monitor $extern -d 1 2 3 4 5 6	

else 
xrandr | grep "$extern disconnected"  
	xrandr --output "$extern" --off --output "$intern" --auto
#	sed -i '8s/.*/pcm "hw:0,0" #SoundIs Normal/' ~/.asoundrc
		bspc monitor $intern -d 1 2 3 4 5 6
fi
;;

"normal")
	xrandr --output "$extern" --off --output "$intern" --auto
#	sed -i '8s/.*/pcm "hw:0,0" #SoundIs Normal/' ~/.asoundrc
		pacmd set-card-profile 0 output:analog-stereo
		pulseaudio -k
		sleep 1s
	       	pulseaudio --start
;;

esac
