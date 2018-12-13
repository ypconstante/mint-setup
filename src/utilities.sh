#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="install flameshot"
my_apt_install flameshot
flameshot config -t false
apt autoremove gnome-screenshot -y -qq --purge
echo "done: $STEP"
