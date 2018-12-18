#!/bin/bash

set -o nounset

if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root"
  exit 1
fi

set -e
sudo true
set +e

cd "$(dirname "$0")"

ASSETS_DIR=$(realpath assets)

XDG_CACHE_HOME="$HOME/.cache"
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"

#################################### FILE #####################################
my_file_contains_line() {
	local file="$1"
	local content="$2"
	grep -Fxq "$content" "$file"
}

my_append_to_file_if_not_contains() {
	local file="$1"
	local content="$2"

	if ! my_file_contains_line "$file" "$content"; then
		if [ -z $file ]; then
			echo "$content" | tee -a "$file" 1>/dev/null
		else
			echo "$content" | sudo tee -a "$file" 1>/dev/null
		fi
	fi
}

################################### OUTPUT ####################################
my_indent() {
	stdbuf -oL -eL $@ | stdbuf -oL -eL sed 's/^/> /g' | sed 's/$//g'
}

################################### INSTALL ###################################
my_apt_install() {
	echo "Installing '$1'"
	my_indent sudo apt-get install -y -qq -o=Dpkg::Use-Pty=0 "$@"
}

my_apt_uninstall() {
	echo "Uninstalling '$1'"
	my_indent sudo apt-get autoremove -y -qq --purge -o=Dpkg::Use-Pty=0 "$@"
}

my_pip_install() {
	echo "Installing '$1'"
	my_indent pip3 install --user "$@"
}
