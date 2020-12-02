#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install flatpak"
my_flatpak_install com.getpostman.Postman
my_step_end
