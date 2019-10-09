#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "add events monitor"
bin_file="$HOME/.local/bin/events-monitor"
autostart_file="$XDG_CONFIG_HOME/autostart/events-monitor.desktop"
my_link_file "$ASSETS_DIR/events--monitor.sh" "$bin_file"
chmod +x "$bin_file"
my_link_file "$ASSETS_DIR/events--monitor.desktop" "$autostart_file"
chmod +x "$autostart_file"
my_step_end
