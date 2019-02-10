#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install franz"
installer_path=/tmp/franz_installer.deb
installer_url=$( \
	curl -sS https://api.github.com/repos/meetfranz/franz/releases/latest \
	| grep browser_download_url	 \
	| grep .deb \
	| sed -E 's/.*"([^"]+)".*/\1/' \
)
curl -L $installer_url -o $installer_path
sudo dpkg --install $installer_path
rm /tmp/franz_installer.deb
my_step_end
