#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install steam"
my_apt_install steam --install-suggests
my_step_end
