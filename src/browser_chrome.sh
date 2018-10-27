#!/bin/bash

set -x

STEP="install chrome"
curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google.list
apt update -y -qq
apt install google-chrome-stable -y -qq
echo "done: $STEP"
