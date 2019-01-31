#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install flameshot"
my_apt_install flameshot
flameshot config -t false
my_apt_uninstall gnome-screenshot
my_step_end

my_step_begin "config redshift"
my_link_file $ASSETS_DIR/utilities--redshift.conf $XDG_CONFIG_HOME/redshift.conf
my_step_end

my_step_begin "install spotify"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
my_apt_add_repository spotify 'deb http://repository.spotify.com stable non-free'
my_apt_install spotify-client
my_step_end

my_step_begin "install virtualbox"
my_apt_add_key https://www.virtualbox.org/download/oracle_vbox_2016.asc
my_apt_add_repository virtualbox "deb https://download.virtualbox.org/virtualbox/debian $UBUNTU_CODENAME contrib"
my_apt_install virtualbox-6.0
my_step_end
