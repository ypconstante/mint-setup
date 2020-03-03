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

my_step_begin "avoid hissing sound when not playing audio"
sudo sed -Ei "s/^load-module module-suspend-on-idle$/#load-module module-suspend-on-idle/" /etc/pulse/default.pa
my_step_end
