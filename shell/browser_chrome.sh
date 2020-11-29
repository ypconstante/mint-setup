#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install chrome"
my_apt_install chromium
my_step_end

my_step_begin "enable incognito chrome"
menu_file="$XDG_DATA_HOME/applications/chromium-incognito.desktop"
my_link_file "$ASSETS_DIR/browser_chrome--incognito-profile.desktop" "$menu_file"
chmod +x "$menu_file"
my_step_end


my_step_begin "enable temporary chrome"
menu_file="$XDG_DATA_HOME/applications/chromium-temporary.desktop"
my_link_file "$ASSETS_DIR/browser_chrome--temp-profile.desktop" "$menu_file"
chmod +x "$menu_file"
my_step_end
