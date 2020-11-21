#!/bin/bash

source "$(dirname "$0")/_base.sh"


my_step_begin "install docker"
my_apt_add_key https://download.docker.com/linux/ubuntu/gpg
my_apt_add_repository docker "deb [arch=amd64] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable"
my_apt_install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker "$USER"
my_step_end

my_step_begin "config docker"
my_link_file "$ASSETS_DIR/dev_containers--docker-daemon.json" /etc/docker/daemon.json
my_step_end

my_step_begin "install docker compose"
docker_compose_file=$HOME/.local/bin/docker-compose
docker_compose_url=$( \
    curl -sS https://api.github.com/repos/docker/compose/releases/latest \
    | jq '[ .assets[].browser_download_url ]' \
    | jq '[ .[] | select(endswith("Linux-x86_64")) ]' \
    | jq -r 'first' \
)
curl -L "$docker_compose_url" -o "$docker_compose_file"
chmod +x "$docker_compose_file"
my_step_end
