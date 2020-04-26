#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install asdf"
my_git_clone https://github.com/asdf-vm/asdf.git "$XDG_DATA_HOME/asdf"
cd "$XDG_DATA_HOME/asdf"
git fetch
git -c advice.detachedHead=false checkout "$(git describe --abbrev=0 --tags)"
my_step_end

my_step_begin "config asdf"
my_link_file "$ASSETS_DIR/dev_asdf--rc" "$ASDF_CONFIG_FILE"
my_step_end
