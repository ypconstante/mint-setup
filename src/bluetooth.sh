#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="replace blueberry with blueman"
my_apt_uninstall blueberry
my_apt_uninstall gnome-bluetooth
my_apt_install blueman
echo "done: $STEP"

STEP="disable blueman applet startup"
cp /etc/xdg/autostart/blueman.desktop $XDG_CONFIG_HOME/autostart/
echo 'X-GNOME-Autostart-enabled=false' >> $XDG_CONFIG_HOME/autostart/blueman.desktop
echo "done: $STEP"

STEP="disable bluetooth automatic power on"
dconf write /org/blueman/plugins/powermanager/auto-power-on false
echo "done: $STEP"
