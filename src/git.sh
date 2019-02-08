#!/bin/bash

source "$(dirname "$0")/_base.sh"

DEFAULT_GITCONFIG_PATH=~/.gitconfig
GITCONFIG_DIR=$XDG_CONFIG_HOME/git
GITCONFIG_FILE=$GITCONFIG_DIR/config
GITIGNORE_FILE=$GITCONFIG_DIR/gitignore

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


my_step_begin "make git respected xdg spec"
mkdir -p $GITCONFIG_DIR

if [ -f $DEFAULT_GITCONFIG_PATH ]; then
	mv $DEFAULT_GITCONFIG_PATH $GITCONFIG_FILE
fi

my_create_file_if_not_exists $GITCONFIG_FILE
my_step_end

my_step_begin "create gitignore"
curl -sS https://www.gitignore.io/api/git,linux,sublimetext,jetbrains+all,visualstudiocode -o $GITIGNORE_FILE
git config --global core.excludesfile $GITIGNORE_FILE
my_step_end

my_step_begin "git config"
git config --global include.path $ASSETS_DIR/git--config
git config --global commit.template $ASSETS_DIR/git--commit-template
my_step_end
