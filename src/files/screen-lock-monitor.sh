#!/bin/bash

disable_bluetooth() {
	pkill blueman-applet
	pkill blueman-manager
	rfkill block bluetooth
}

run() {
	disable_bluetooth
}

run

dbus-monitor --session "type='signal',interface='org.cinnamon.ScreenSaver'" |
	while read x; do
		case "$x" in 
			*"boolean true"*)
				run;;
    	esac
  	done