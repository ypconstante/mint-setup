#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install docker"
my_apt_add_key https://download.docker.com/linux/ubuntu/gpg
my_apt_add_repository docker "deb [arch=amd64] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable"
my_apt_install docker-ce docker-ce-cli containerd.io
my_step_end

my_step_begin "add user to docker group"
sudo groupadd docker
sudo usermod -aG docker "$USER"
my_step_end
