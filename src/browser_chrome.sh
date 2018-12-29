#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install chrome"
my_apt_install chromium-browser
my_step_end
