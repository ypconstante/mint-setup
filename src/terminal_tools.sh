#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install cli tools"
my_apt_install autojump
my_apt_install inotify-tools
my_apt_install jq
my_apt_install moreutils
my_apt_install tldr
my_step_end
