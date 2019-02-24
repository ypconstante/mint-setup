#!/bin/bash

source "$(dirname "$0")/_base.sh"

install_dir=$XDG_DATA_HOME/JetBrains/Toolbox
installer_compressed_file=/tmp/jetbrains-toolbox.tar.gz
installer_dir=/tmp/jetbrains-toolbox

if [ -d "$install_dir" ]; then
    my_step_begin "install toolbox"
    echo 'toolbox already installed'
    my_step_end
    return
fi

my_step_begin "download toolbox"
curl -L 'https://data.services.jetbrains.com/products/download?platform=linux&code=TBA' -o "$installer_compressed_file"
my_step_end

my_step_begin "extract installer"
mkdir $installer_dir
tar -xzf $installer_compressed_file -C $installer_dir --strip-components=1
my_step_end

my_step_begin "config toolbox"
mkdir -p "$install_dir"
my_link_file "$ASSETS_DIR/dev_jetbrains-toolbox--settings.json" "$install_dir/.settings.json"
my_step_end

my_step_begin "install toolbox"
$installer_dir/jetbrains-toolbox

sleep 2
pkill jetbrains-toolb
my_step_end

my_step_begin "remove installer"
rm $installer_compressed_file
rm -r $installer_dir
my_step_end
