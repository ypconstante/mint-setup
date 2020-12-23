#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install zoom"
my_flatpak_install com.github.tchx84.Flatseal
my_step_end
