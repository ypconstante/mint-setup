#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install tig"
my_apt_install tig
my_step_end

my_step_begin "create ssh folder"
mkdir -p -m 700 ~/.ssh
my_step_end

my_step_begin "add github and gitlab as known ssh hosts"
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
ssh-keyscan -t rsa gitlab.com >> ~/.ssh/known_hosts
my_step_end

my_step_begin "create gitignore"
curl -sS https://www.gitignore.io/api/git,linux,sublimetext,jetbrains+all,visualstudiocode -o ~/projects/gitignore.gitignore
git config --global core.excludesfile '~/projects/gitignore.gitignore'
my_step_end

my_step_begin "git config"
git config --global include.path $ASSETS_DIR/git--gitconfig
my_step_end
