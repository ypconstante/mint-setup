#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root"
  exit 1
fi

cd "$(dirname "$0")"

./prepare.sh
./packages.sh
./desktop.sh
./filesystem.sh
./git.sh
./peripherals.sh
./sound.sh
