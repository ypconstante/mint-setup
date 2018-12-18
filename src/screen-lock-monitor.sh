#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="add screen lock monitor"
mkdir -p ~/.var/scripts
cp $ASSETS_DIR/screen-lock-monitor.sh ~/.var/scripts/
chmod +x ~/.var/scripts/screen-lock-monitor.sh
cp $ASSETS_DIR/screen-lock-monitor.desktop $XDG_CONFIG_HOME/autostart/
echo 'Exec="'$HOME'/.var/scripts/screen-lock-monitor.sh"' >> $XDG_CONFIG_HOME/autostart/screen-lock-monitor.desktop
echo "done: $STEP"
