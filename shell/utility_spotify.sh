#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install spotify"
my_flatpak_install com.spotify.Client
my_step_end
