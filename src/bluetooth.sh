#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="replace blueberry with blueman"
apt autoremove blueberry -y -qq --purge
apt autoremove gnome-bluetooth -y -qq --purge
my_apt_install blueman
echo "done: $STEP"

STEP="disable blueman applet startup"
cp /etc/xdg/autostart/blueman.desktop ~/.config/autostart/
echo 'X-GNOME-Autostart-enabled=false' >> ~/.config/autostart/blueman.desktop
echo "done: $STEP"

STEP="disable bluetooth automatic power on"
dconf write /org/blueman/plugins/powermanager/auto-power-on false
echo "done: $STEP"
