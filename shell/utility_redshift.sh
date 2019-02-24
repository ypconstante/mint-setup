#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "config redshift"
my_link_file "$ASSETS_DIR/utility_redshift.conf" "$XDG_CONFIG_HOME/redshift.conf"
my_step_end
