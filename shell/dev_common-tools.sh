#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install common dev tools"
my_apt_install build-essential
my_apt_install g++
my_apt_install gcc
my_apt_install make
my_step_end
