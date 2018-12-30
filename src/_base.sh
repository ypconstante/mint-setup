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
		if [ -w $file ]; then
			echo "$content" | tee -a "$file" 1>/dev/null
		else
			echo "$content" | sudo tee -a "$file" 1>/dev/null
		fi
	fi
}

################################### OUTPUT ####################################
my_echo_error() {
	local message="$@"
	echo "$(tput setaf 1)$message$(tput sgr0)"
}

my_echo_step() {
	local message="$@"
	echo "$(tput setab 7)$(tput setaf 0)$message$(tput el)$(tput sgr0)"
}

my_step_begin() {
	local step="$@"

	if [ -z "${step-}" ]; then
		my_echo_error 'step name not given'
	fi

	if [ -z "${STEP-}" ]; then
		STEP="$step"
		my_echo_step "starting: $STEP"
	else
		my_echo_error "can't start step '$step', step '$STEP' not ended"
	fi
}

my_step_end() {
	if [ ! -z "${STEP-}" ]; then
		my_echo_step "done: $STEP"
		echo ''
		unset STEP
	else
		my_echo_error "no step to end"
	fi
}

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
