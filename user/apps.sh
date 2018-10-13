#!/bin/bash

STEP="install flameshot"
apt install flameshot -y -qq
flameshot config -t false
apt remove gnome-screenshot -y -qq
echo "done: $STEP"
