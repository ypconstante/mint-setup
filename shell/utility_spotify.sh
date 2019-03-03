#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install spotify"
sudo apt-key --quiet adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
my_apt_add_repository spotify 'deb http://repository.spotify.com stable non-free'
my_apt_install spotify-client
my_step_end
