#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "config environment variables"
sed -E 's/^export ([^=]*)/\1 DEFAULT/g' "$ASSETS_DIR/base--env" > ~/.pam_environment
my_step_end
