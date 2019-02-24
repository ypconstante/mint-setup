#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "network kernel parameters"
sudo cp "$ASSETS_DIR/network--kernel-parameters.conf" /etc/sysctl.d/98-network.conf
sudo chmod 644 /etc/sysctl.d/98-network.conf
my_step_end

my_step_begin "disable wifi power management"
sudo sed -Ei 's/wifi.powersave = 3/wifi.powersave = 2/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
my_step_end
