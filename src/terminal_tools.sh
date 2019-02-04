#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install cli tools"
my_apt_install autojump
my_apt_install inotify-tools
my_apt_install jq
my_apt_install tldr
my_step_end

my_step_begin "install thefuck"
my_apt_install python3-dev
my_apt_install python3-pip
my_apt_install python3-setuptools
my_pip_install wheel
my_pip_install thefuck
my_step_end
