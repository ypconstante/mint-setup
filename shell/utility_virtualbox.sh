#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install virtualbox"
my_apt_add_key https://www.virtualbox.org/download/oracle_vbox_2016.asc
my_apt_add_repository virtualbox "deb https://download.virtualbox.org/virtualbox/debian $UBUNTU_CODENAME contrib"
my_apt_install virtualbox-6.1
my_step_end
