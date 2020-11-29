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

ASSETS_DIR=$(realpath ../assets)

source /etc/os-release
source "$ASSETS_DIR/base--env"

#################################### FILE #####################################
my_link_file() {
    local from="$1"
    local to="$2"
    if [[ "$to" == */ ]]; then
        local filename="$(basename "$from")"
        to="${to}${filename}"
    fi
    rm -f "$to" 2> /dev/null || sudo rm -f "$to"
    ln -s "$from" "$to" 2> /dev/null || sudo ln -s "$from" "$to"
}

my_create_file_if_not_exists() {
    local file="$1"
    touch "$file" 2> /dev/null || sudo touch "$file"
}

my_wait_file() {
    local file="$1"
    local time_waiting=0;

    until [ -f "$file" ]; do
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
            return 1
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
        if [ -w "$file" ]; then
            echo "$content" | tee -a "$file" 1>/dev/null
        else
            echo "$content" | sudo tee -a "$file" 1>/dev/null
        fi
    fi
}

my_run_files() {
    sort -zn | xargs -0 -I '{}' bash '{}' \;
}

################################### OUTPUT ####################################
my_echo_without_line_break() {
    local message="$1"
    echo -n "$message"
}

my_echo_clear_line() {
    echo -en "\r$(tput el)"
}

my_echo_error() {
    local message="$1"
    echo "$(tput setaf 1)$message$(tput sgr0)"
}

my_echo_step() {
    local message="$1"
    echo "$(tput setab 7)$(tput setaf 0)$message$(tput el)$(tput sgr0)"
}

my_step_begin() {
    local step="$1"

    if [ -z "${step-}" ]; then
        my_echo_error 'step name not given'
    fi

    if [ -z "${current_step-}" ]; then
        current_step="$step"
        my_echo_step "starting: $current_step"
    else
        my_echo_error "can't start step '$step', step '$current_step' not ended"
    fi
}

my_step_end() {
    if [ ! -z "${current_step-}" ]; then
        my_echo_step "done: $current_step"
        echo ''
        unset current_step
    else
        my_echo_error "no step to end"
    fi
}

my_echo_substep() {
    local message="$1"
    echo "$(tput bold)$(tput setaf 4)$message$(tput el)$(tput sgr0)"
}

################################### INSTALL ###################################
my_apt_add_key() {
    local url="$1"
    my_echo_without_line_break "Adding key '$url'"
    curl -sS "$url" | sudo apt-key --quiet add -
    my_echo_clear_line
}

my_apt_add_repository() {
    local name="$1"
    local source="$2"

    my_echo_without_line_break "Adding repository '$name'"
    my_append_to_file_if_not_contains "/etc/apt/sources.list.d/$name.list" "$source"
    my_echo_clear_line
    my_apt_update
}

my_apt_add_ppa_repository() {
    local name="$1"

    my_echo_substep "Adding repository '$name'"
    sudo add-apt-repository -y "$name"
    my_echo_substep "Added repository '$name'"
    my_apt_update
}

my_apt_update() {
    my_echo_without_line_break "Updating packages info"
    sudo apt-get update -y -qq 1> /dev/null
    my_echo_clear_line
}

my_apt_install() {
    my_echo_substep "Installing '$1'"
    sudo apt-get install -y -qq "$@"
    my_echo_substep "Installed '$1'"
}

my_apt_uninstall() {
    my_echo_substep "Uninstalling '$1'"
    sudo apt-get autoremove -y -qq --purge "$@"
    my_echo_substep "Uninstalled '$1'"
}

my_flatpak_install() {
    my_echo_substep "Installing '$1'"
    flatpak install -y flathub "$@"
    my_echo_substep "Installed '$1'"
}

my_asdf_install_and_set_global() {
    local package="$1"
    local version="$2"
    source "$XDG_DATA_HOME/asdf/asdf.sh"
    my_step_begin "install $package"
    echo "installing $package version $version"
    asdf install "$package" "$version"
    asdf global "$package" "$version"
    my_step_end
}


my_git_clone() {
    local repository="$1"
    local directory="$2"

    if [ -d "$directory" ]; then
        local previous_dir=$PWD
        cd "$directory"
        echo "Updating repo '$directory'"
        git remote set-url origin "$repository"
        if [ "$(git symbolic-ref --short -q HEAD)" ]; then
            git pull
        else
            git fetch
        fi
        cd "$previous_dir"
    else
        git clone "$repository" "$directory"
    fi
}

my_command_exists () {
    local command="$1"
    type "$command" &> /dev/null
}
