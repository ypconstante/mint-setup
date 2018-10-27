#!/bin/bash

set -x

STEP="network kernel parameters"
sudo cp ./files/network-sysctl.conf /etc/sysctl.d/98-network.conf
echo "done: $STEP"

STEP="disable wifi power management"
sudo sed -i 's/wifi.powersave = 3/wifi.powersave = 2/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
echo "done: $STEP"
