#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install vlc"
my_apt_install vlc
my_step_end
