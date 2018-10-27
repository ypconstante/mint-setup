#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root"
  exit 1
fi

set -x
set -e
sudo true
set +e

cd "$(dirname "$0")"

./prepare.sh
./packages.sh
./browsers.sh
./desktop.sh
./file-manager.sh
./filesystem.sh
./git.sh
./network.sh
./peripherals.sh
./sound.sh
./update-manager.sh
