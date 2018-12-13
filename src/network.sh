#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="network kernel parameters"
sudo cp $ASSETS/network--kernel-parameters.conf /etc/sysctl.d/98-network.conf
sudo chmod 644 /etc/sysctl.d/98-network.conf
echo "done: $STEP"

STEP="disable wifi power management"
sudo sed -i 's/wifi.powersave = 3/wifi.powersave = 2/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
echo "done: $STEP"
