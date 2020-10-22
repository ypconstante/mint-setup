#!/bin/bash

source "$(dirname "$0")/_base.sh"

config_dir=$XDG_CONFIG_HOME/nano

my_step_begin "configure nano"
mkdir -p "$config_dir"
my_link_file "$ASSETS_DIR/terminal_nano--rc" "$config_dir/nanorc"
my_git_clone https://github.com/scopatz/nanorc.git "$config_dir/syntax"
cd "$config_dir/syntax"
git checkout v2.9
my_step_end
