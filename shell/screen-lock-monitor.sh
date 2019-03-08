#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "add screen lock monitor"
bin_file="$HOME/.local/bin/screen-lock-monitor"
autostart_file="$XDG_CONFIG_HOME/autostart/screen-lock-monitor.desktop"
my_link_file "$ASSETS_DIR/screen-lock-monitor.sh" "$bin_file"
chmod +x "$bin_file"
my_link_file "$ASSETS_DIR/screen-lock-monitor.desktop" "$autostart_file"
chmod +x "$autostart_file"
my_step_end
