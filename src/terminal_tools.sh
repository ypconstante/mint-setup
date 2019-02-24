#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install cli tools"
my_apt_install autojump
my_apt_install inotify-tools
my_apt_install jq
my_apt_install moreutils
my_apt_install tldr
my_step_end

my_step_begin "install up"
up_path=$HOME/.local/bin/up
up_url=$( \
    curl -sS https://api.github.com/repos/akavel/up/releases/latest \
    | jq '[ .assets[].browser_download_url ]' \
    | jq '[ .[] | select(endswith("/up")) ]' \
    | jq -r 'first' \
)
curl -L $up_url -o $up_path
chmod +x $up_path
my_step_end
