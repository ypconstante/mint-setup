#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "configure system monitor"
dconf write /org/gnome/gnome-system-monitor/show-whose-processes "'all'"
dconf write /org/gnome/gnome-system-monitor/proctree/sort-col 15
my_step_end
