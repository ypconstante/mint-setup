#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install podman"
my_apt_add_ppa_repository ppa:projectatomic/ppa
my_apt_install podman --install-recommends
sudo curl -sS https://raw.githubusercontent.com/projectatomic/registries/master/registries.fedora -o /etc/containers/registries.conf
my_step_end
