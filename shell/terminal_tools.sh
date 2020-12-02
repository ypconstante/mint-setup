#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install cli tools"
my_apt_install autojump
my_apt_install jq
my_apt_install inotify-tools
my_apt_install moreutils
my_apt_install xclip
my_apt_install xdotool
my_step_end

my_step_begin "install up"
my_apt_install tldr
tldr tldr &> /dev/null
tldr --update
my_step_end

my_step_begin "install up"
up_file=$HOME/.local/bin/up
up_url=$( \
    curl -sS https://api.github.com/repos/akavel/up/releases/latest \
    | jq '[ .assets[].browser_download_url ]' \
    | jq '[ .[] | select(endswith("/up")) ]' \
    | jq -r 'first' \
)
curl -L "$up_url" -o "$up_file"
chmod +x "$up_file"
my_step_end

my_step_begin "install playerctl"
installer_url=$( \
    curl -sS https://api.github.com/repos/altdesktop/playerctl/releases/latest \
    | jq '[ .assets[].browser_download_url ]' \
    | jq '[ .[] | select(endswith(".deb")) ]' \
    | jq -r 'first' \
)
installer_file="/tmp/$(basename "$installer_url")"
curl -L "$installer_url" -o "$installer_file"
sudo dpkg --install "$installer_file"
rm "$installer_file"
my_step_end
