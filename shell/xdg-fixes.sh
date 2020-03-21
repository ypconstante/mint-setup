#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "xdg wget"
my_append_to_file_if_not_contains "$XDG_CONFIG_HOME/wgetrc" "hsts-file = ${XDG_CACHE_HOME}/wget-hsts"
rm -f "$HOME/.wget-hsts"
my_step_end
