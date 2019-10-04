#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install franz"
if my_command_exists franz; then
    echo 'franz already installed'
else
    installer_url=$( \
        curl -sS https://api.github.com/repos/meetfranz/franz/releases/latest \
        | jq '[ .assets[].browser_download_url ]' \
        | jq '[ .[] | select(endswith(".deb")) ]' \
        | jq -r 'first' \
    )
    installer_file=$(basename "$installer_url")
    curl -L "$installer_url" -o "$installer_file"
    sudo dpkg --install "$installer_file"
    rm "$installer_file"
fi
my_step_end
