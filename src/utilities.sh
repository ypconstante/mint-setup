#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install flameshot"
my_apt_install flameshot
flameshot config -t false
my_apt_uninstall gnome-screenshot
my_step_end

my_step_begin "config redshift"
cp $ASSETS_DIR/utilities--redshift.conf $XDG_CONFIG_HOME/redshift.conf
my_step_end

my_step_begin "install virtualbox"
my_apt_add_key https://www.virtualbox.org/download/oracle_vbox_2016.asc
my_apt_add_repository virtualbox "deb https://download.virtualbox.org/virtualbox/debian $UBUNTU_CODENAME contrib"
my_apt_install virtualbox-6.0
my_step_end
