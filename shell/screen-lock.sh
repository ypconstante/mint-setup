#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "config screen lock"
dconf write /org/cinnamon/desktop/screensaver/allow-keyboard-shortcuts false
dconf write /org/cinnamon/desktop/screensaver/allow-media-control false
dconf write /org/cinnamon/desktop/screensaver/show-album-art false
dconf write /org/cinnamon/desktop/screensaver/show-info-panel false
dconf write /org/cinnamon/desktop/screensaver/floating-widgets false
my_step_end

my_step_begin "add screen lock monitor"
bin_file="$HOME/.local/bin/screen-lock-monitor"
autostart_file="$XDG_CONFIG_HOME/autostart/screen-lock-monitor.desktop"
my_link_file "$ASSETS_DIR/screen-lock--monitor.sh" "$bin_file"
chmod +x "$bin_file"
my_link_file "$ASSETS_DIR/screen-lock--monitor.desktop" "$autostart_file"
chmod +x "$autostart_file"
my_step_end
