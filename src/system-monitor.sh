#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="configure system monitor"
dconf write /org/gnome/gnome-system-monitor/show-whose-processes "'all'"
dconf write /org/gnome/gnome-system-monitor/proctree/sort-col 15
echo "done: $STEP"
