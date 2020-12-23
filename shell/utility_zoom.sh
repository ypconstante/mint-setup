#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install zoom"
APP_NAME=us.zoom.Zoom
my_flatpak_install $APP_NAME
flatpak override --user $APP_NAME --reset
flatpak override --user $APP_NAME \
    --nofilesystem=~/.zoom \
    --persist=.zoom \
    --nofilesystem=~/Documents/Zoom \
    --persist=Documents
my_step_end

