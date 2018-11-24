#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="install chrome"
curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google.list
apt update -y -qq
my_apt_install google-chrome-stable
echo "done: $STEP"
