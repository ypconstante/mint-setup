#!/bin/bash

STEP="modify mouse and touchpad settings"
# rename with double click
dconf write /org/nemo/preferences/quick-renames-with-pause-in-between true
# locate cursor with ctrl
dconf write /org/cinnamon/settings-daemon/peripherals/mouse/locate-pointer false
# disable left+right click to middle click
dconf write /org/cinnamon/settings-daemon/peripherals/mouse/middle-button-enabled false
# disable tap to click
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/tap-to-click false
# scroll two fingers
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/scrolling-method 1
echo "done: $STEP"

STEP="modify keyboard settings"
dconf write /org/gnome/libgnomekbd/keyboard/options "['caps\tcaps:none']"
dconf load /org/cinnamon/desktop/keybindings/ < files/keyboard-bindings.dconf
echo "done: $STEP"
