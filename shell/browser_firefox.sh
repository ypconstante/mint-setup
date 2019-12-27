#!/bin/bash

source "$(dirname "$0")/_base.sh"

profile_name='default-release'

my_firefox_profile_dir() {
    [[ -d ~/.mozilla/firefox ]] && find ~/.mozilla/firefox -maxdepth 1 -name "*.$profile_name" | head -n 1
}

my_firefox_close() {
    killall -9 firefox
}

if [[ ! -d $(my_firefox_profile_dir) ]]; then
    my_step_begin "firefox profile check"
    my_echo_error "no firefox profile available"
    my_step_end
    exit
fi

my_step_begin "close firefox"
my_firefox_close
my_step_end

my_step_begin "config firefox"
my_link_file "$ASSETS_DIR/browser_firefox--search.json.mozlz4" "$(my_firefox_profile_dir)/search.json.mozlz4"
my_link_file "$ASSETS_DIR/browser_firefox--user.js" "$(my_firefox_profile_dir)/user.js"

mkdir -p "$(my_firefox_profile_dir)/chrome"
my_link_file "$ASSETS_DIR/browser_firefox--userChrome.css" "$(my_firefox_profile_dir)/chrome/userChrome.css"
my_link_file "$ASSETS_DIR/browser_firefox--userContent.css" "$(my_firefox_profile_dir)/chrome/userContent.css"
my_step_end

my_step_begin "enable temporary firefox"
bin_file="$HOME/.local/bin/firefox-temp"
menu_file="$XDG_DATA_HOME/applications/firefox-temp.desktop"
my_link_file "$ASSETS_DIR/browser_firefox--temp-profile.sh" "$bin_file"
chmod +x "$bin_file"
my_link_file "$ASSETS_DIR/browser_firefox--temp-profile.desktop" "$menu_file"
chmod +x "$menu_file"
my_step_end
