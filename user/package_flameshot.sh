#!/bin/bash

STEP="install flameshot"
apt install flameshot -y -qq
flameshot config -t false
apt autoremove gnome-screenshot -y -qq --purge
echo "done: $STEP"
