#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "memory kernel parameters"
sudo cp "$ASSETS_DIR/memory--kernel-parameters.conf" /etc/sysctl.d/98-memory.conf
sudo chmod 644 /etc/sysctl.d/98-memory.conf
my_step_end
