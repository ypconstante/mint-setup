#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install dconf editor"
my_apt_install dconf-editor
my_step_end

my_step_begin "config dconf editor"
dconf write /ca/desrt/dconf-editor/show-warning false
my_step_end
