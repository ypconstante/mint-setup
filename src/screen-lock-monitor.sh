#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "add screen lock monitor"
mkdir -p ~/.var/scripts
cp $ASSETS_DIR/screen-lock-monitor.sh ~/.var/scripts/
chmod +x ~/.var/scripts/screen-lock-monitor.sh
cp $ASSETS_DIR/screen-lock-monitor.desktop $XDG_CONFIG_HOME/autostart/
echo 'Exec="'$HOME'/.var/scripts/screen-lock-monitor.sh"' >> $XDG_CONFIG_HOME/autostart/screen-lock-monitor.desktop
my_step_end
