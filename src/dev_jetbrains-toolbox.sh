#!/bin/bash

source "$(dirname "$0")/_base.sh"

toolbox_dir=$XDG_DATA_HOME/JetBrains/Toolbox
toolbox_installer_compressed=/tmp/jetbrains-toolbox.tar.gz
toolbox_installer_dir=/tmp/jetbrains-toolbox

if [ -d $toolbox_dir ]; then
	my_step_begin "install toolbox"
	echo 'toolbox already installed'
	my_step_end
	return
fi

my_step_begin "download toolbox"
curl -L 'https://data.services.jetbrains.com/products/download?platform=linux&code=TBA' -o $toolbox_installer_compressed
my_step_end

my_step_begin "extract installer"
mkdir $toolbox_installer_dir
tar -xzf $toolbox_installer_compressed -C $toolbox_installer_dir --strip-components=1
my_step_end

my_step_begin "config toolbox"
mkdir -p $toolbox_dir
my_link_file $ASSETS_DIR/dev_jetbrains-toolbox--settings.json $toolbox_dir/.settings.json
my_step_end

my_step_begin "install toolbox"
$toolbox_installer_dir/jetbrains-toolbox

sleep 2
pkill jetbrains-toolb
my_step_end

my_step_begin "remove installer"
rm $toolbox_installer_compressed
rm -r $toolbox_installer_dir
my_step_end
