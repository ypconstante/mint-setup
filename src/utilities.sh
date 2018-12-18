#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="install flameshot"
my_apt_install flameshot
flameshot config -t false
my_apt_uninstall gnome-screenshot
echo "done: $STEP"

STEP="config redshift"
cp $ASSETS_DIR/utilities--redshift.conf $XDG_CONFIG_HOME/redshift.conf
echo "done: $STEP"
