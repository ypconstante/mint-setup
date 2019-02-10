#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install visual studio code"
my_apt_add_key https://packages.microsoft.com/keys/microsoft.asc
my_apt_add_repository vscode 'deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main'
my_apt_install code
my_step_end

my_step_begin "configure visual studio code"
mkdir -p $XDG_CONFIG_HOME/Code/User
my_link_file $ASSETS_DIR/dev_visual-studio-code--settings.json $XDG_CONFIG_HOME/Code/User/settings.json
my_step_end
