#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install zoom"
my_flatpak_install us.zoom.Zoom
flatpak override --user us.zoom.Zoom --reset
flatpak override --user us.zoom.Zoom \
    --nofilesystem=~/.zoom \
    --nofilesystem=~/Documents/Zoom \
    --nofilesystem=xdg-documents \
    --persist=~/.zoom \
    --persist=~/Documents \
    --persist=xdg-documents
my_step_end

