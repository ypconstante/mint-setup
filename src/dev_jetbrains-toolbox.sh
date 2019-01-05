#!/bin/bash

source "$(dirname "$0")/_base.sh"

toolbox_dir=$XDG_DATA_HOME/JetBrains/Toolbox
toolbox_gz=$HOME/toolbox.tar.gz
toolbox_output_dir=$HOME/toolbox

if [ -d $toolbox_dir ]; then
	my_step_begin "install toolbox"
	echo 'toolbox already installed'
	my_step_end
	return
fi

my_step_begin "download toolbox"
curl -L 'https://data.services.jetbrains.com/products/download?platform=linux&code=TBA' -o $toolbox_gz
my_step_end

my_step_begin "extract installer"
mkdir $toolbox_output_dir
tar -xzf $toolbox_gz -C $toolbox_output_dir --strip-components=1
my_step_end

my_step_begin "config toolbox"
mkdir -p $toolbox_dir
cp $ASSETS_DIR/dev_jetbrains-toolbox--settings.json $toolbox_dir/.settings.json
my_step_end

my_step_begin "install toolbox"
$toolbox_output_dir/jetbrains-toolbox

sleep 2
pkill jetbrains-toolb
my_step_end

my_step_begin "remove installer"
rm $toolbox_gz
rm -r $toolbox_output_dir
my_step_end
