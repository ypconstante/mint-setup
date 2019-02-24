#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "config gnome screenshot"
dconf write /org/gnome/gnome-screenshot/auto-save-directory "'file:///$HOME/downloads/'"
my_step_end
