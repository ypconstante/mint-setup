#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install remmina"
my_flatpak_install org.remmina.Remmina
my_step_end
