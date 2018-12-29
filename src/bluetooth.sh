#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "replace blueberry with blueman"
my_apt_uninstall blueberry
my_apt_uninstall gnome-bluetooth
my_apt_install blueman
my_step_end

my_step_begin "disable blueman applet startup"
cp /etc/xdg/autostart/blueman.desktop $XDG_CONFIG_HOME/autostart/
echo 'X-GNOME-Autostart-enabled=false' >> $XDG_CONFIG_HOME/autostart/blueman.desktop
my_step_end

my_step_begin "disable bluetooth automatic power on"
dconf write /org/blueman/plugins/powermanager/auto-power-on false
my_step_end
