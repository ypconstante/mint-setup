#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install common dev tools"
my_apt_install build-essential g++ gcc make
my_step_end
