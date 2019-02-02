#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install flameshot"
my_apt_install flameshot
flameshot config -t false
my_apt_uninstall gnome-screenshot
my_step_end
