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

source /etc/os-release
source $ASSETS_DIR/base--env

#################################### FILE #####################################
my_create_file_if_not_exists() {
	local file="$1"
	touch $file 2> /dev/null || sudo touch $file
}

my_wait_file() {
	local file="$1"
	local time_waiting=0;

	until [ -f $file ]; do
		sleep 1
		((time_waiting++))
		if [[ $time_waiting -eq 2 ]]; then
			echo -n "Waiting file '$file' to be created "
		elif [[ $time_waiting -gt 2 ]]; then
			echo -n "#"
		fi
		if [[ $time_waiting -gt 20 ]]; then
			echo ''
			my_echo_error 'Wait aborted after 20 seconds, file not created'
			return -1
		fi
	done

	if [[ $time_waiting -ge 2 ]]; then
		echo ''
		echo 'File created'
	fi
}

my_file_contains_line() {
	local file="$1"
	local content="$2"
	grep -Fxq "$content" "$file"
}

my_append_to_file_if_not_contains() {
	local file="$1"
	local content="$2"

	my_create_file_if_not_exists "$file"

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
my_apt_add_key() {
	local url="$1"
	curl -sS $url | sudo apt-key add -
}

my_apt_add_repository() {
	local name="$1"
	local source="$2"
	
	my_append_to_file_if_not_contains /etc/apt/sources.list.d/$name.list "$source"
	apt update -y -qq
}

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
