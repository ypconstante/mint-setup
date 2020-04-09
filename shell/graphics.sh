#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install vulkan"
my_apt_install libvulkan1 libvulkan1:i386
my_apt_install mesa-vulkan-drivers mesa-vulkan-drivers:i386
my_apt_install vulkan-utils
my_step_end
