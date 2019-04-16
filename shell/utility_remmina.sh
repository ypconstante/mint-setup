#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install remmina"
my_apt_add_ppa ppa:remmina-ppa-team/remmina-next
my_apt_install remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice
my_step_end
