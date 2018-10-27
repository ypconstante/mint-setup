#!/bin/bash

set -x

STEP="network kernel parameters"
sudo cp ./files/network-sysctl.conf /etc/sysctl.d/98-network.conf
echo "done: $STEP"
