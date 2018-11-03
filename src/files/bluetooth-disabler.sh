#!/bin/bash

disable_bluetooth() {
	pkill blueman-applet
	pkill blueman-manager
	rfkill block bluetooth
}

disable_bluetooth

dbus-monitor --session "type='signal',interface='org.cinnamon.ScreenSaver'" |
	while read x; do
		case "$x" in 
			*"boolean true"*)
				disable_bluetooth;;
    	esac
  	done