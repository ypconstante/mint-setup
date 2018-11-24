#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="install flameshot"
apt install flameshot -y -qq
flameshot config -t false
apt autoremove gnome-screenshot -y -qq --purge
echo "done: $STEP"
