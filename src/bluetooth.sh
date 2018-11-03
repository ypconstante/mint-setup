#!/bin/bash

set -x

STEP="replace blueberry with blueman"
apt autoremove blueberry -y -qq --purge
apt autoremove gnome-bluetooth -y -qq --purge
apt install blueman -y -qq
echo "done: $STEP"

STEP="disable blueman applet startup"
cp /etc/xdg/autostart/blueman.desktop ~/.config/autostart/
echo 'X-GNOME-Autostart-enabled=false' >> ~/.config/autostart/blueman.desktop
echo "done: $STEP"

STEP="disable bluetooth automatic power on"
dconf write /org/blueman/plugins/powermanager/auto-power-on false
echo "done: $STEP"

STEP="disable bluetooth at login and at screen lock"
mkdir -p ~/.local/scripts
cp files/bluetooth-disabler.sh ~/.local/scripts/
chmod +x ~/.local/scripts/bluetooth-disabler.sh
cp files/bluetooth-disabler.desktop ~/.config/autostart/
echo 'Exec="'$HOME'/.local/scripts/bluetooth-disabler.sh"' >> ~/.config/autostart/bluetooth-disabler.desktop
echo "done: $STEP"
