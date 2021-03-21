#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "disable system sounds"
dconf write /org/cinnamon/sounds/login-enabled false
dconf write /org/cinnamon/sounds/logout-enabled false
dconf write /org/cinnamon/sounds/unplug-enabled false
dconf write /org/cinnamon/sounds/tile-enabled false
dconf write /org/cinnamon/sounds/plug-enabled false
dconf write /org/cinnamon/sounds/switch-enabled false
my_step_end

my_step_begin "setup pulseaudio"
my_link_file "$ASSETS_DIR/sound--pulseaudio.po" "$XDG_CONFIG_HOME/pulse/default.po"
my_step_end

my_step_begin "configure sound kernel module"
sudo cp "$ASSETS_DIR/sound--kernel-module.conf" /etc/modprobe.d/sound.conf
my_step_end
