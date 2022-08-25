#! /bin/sh 

if [[ $(xrandr -q | grep 'HDMI-1 connected') ]];then
	xrandr --output eDP-1 --mode 1920x1080 --primary --output HDMI-1 --left-of eDP-1 --mode 1920x1080
 
fi  

