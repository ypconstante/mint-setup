#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "download shellcheck"
my_apt_install shellcheck
my_step_end
