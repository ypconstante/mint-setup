#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="install chrome"
my_apt_install chromium-browser
echo "done: $STEP"
