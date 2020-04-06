#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install podman"
my_apt_add_key https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_18.04/Release.key
my_apt_add_repository libcontainers "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_18.04/ /"
my_apt_install podman --install-recommends

sudo curl -sS https://raw.githubusercontent.com/projectatomic/registries/master/registries.fedora -o /etc/containers/registries.conf
sudo curl -sS https://raw.githubusercontent.com/containers/skopeo/master/default-policy.json -o /etc/containers/policy.json

# fix "not enough IDs available"
podman system migrate
my_step_end
