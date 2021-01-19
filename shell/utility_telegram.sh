#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install telegram"
my_flatpak_install org.telegram.desktop
my_step_end
