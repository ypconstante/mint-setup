#!/bin/bash

STEP="add screen lock monitor"
mkdir -p ~/.var/scripts
cp files/screen-lock-monitor.sh ~/.var/scripts/
chmod +x ~/.var/scripts/screen-lock-monitor.sh
cp files/screen-lock-monitor.desktop ~/.config/autostart/
echo 'Exec="'$HOME'/.var/scripts/screen-lock-monitor.sh"' >> ~/.config/autostart/screen-lock-monitor.desktop
echo "done: $STEP"
