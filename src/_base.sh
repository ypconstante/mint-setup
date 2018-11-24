#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root"
  exit 1
fi

set -e
sudo true
set +e

cd "$(dirname "$0")"

my_indent() {
	stdbuf -oL -eL $@ | stdbuf -oL -eL sed 's/^/> /g' | sed 's/$//g'
}

my_apt_install() {
	echo "Installing '$0'"
	my_indent sudo apt-get install -y -qq -o=Dpkg::Use-Pty=0 "$@"
}
