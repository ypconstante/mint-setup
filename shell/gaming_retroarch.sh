#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install retroarch"
my_apt_add_ppa_repository ppa:libretro/stable
my_apt_install retroarch*
my_step_end


