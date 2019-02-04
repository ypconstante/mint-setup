#!/bin/bash

source "$(dirname "$0")/_base.sh"

CONFIG_DIR=~/.config/nano

my_step_begin "configure nano"
mkdir -p $CONFIG_DIR
my_link_file $ASSETS_DIR/terminal_nano--rc $CONFIG_DIR/nanorc
git clone https://github.com/scopatz/nanorc.git $CONFIG_DIR/syntax
my_step_end
