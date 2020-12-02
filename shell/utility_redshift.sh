#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "config redshift"
my_link_file "$ASSETS_DIR/utility_redshift.conf" "$XDG_CONFIG_HOME/redshift.conf"
cp /usr/share/applications/redshift-gtk.desktop "$XDG_CONFIG_HOME/autostart/"
my_append_to_file_if_not_contains "$XDG_CONFIG_HOME/autostart/redshift-gtk.desktop" 'X-GNOME-Autostart-enabled=true'
my_append_to_file_if_not_contains "$XDG_CONFIG_HOME/autostart/redshift-gtk.desktop" 'Hidden=false'
my_step_end
