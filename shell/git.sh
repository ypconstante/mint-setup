#!/bin/bash

source "$(dirname "$0")/_base.sh"

default_config_file=~/.gitconfig
config_dir=$XDG_CONFIG_HOME/git
config_file=$config_dir/config
git_ignore_file=$config_dir/gitignore

my_step_begin "install tig"
my_apt_install tig
my_step_end

my_step_begin "create ssh folder"
mkdir -p -m 700 ~/.ssh
my_step_end

my_step_begin "add known ssh hosts"
for host in 'bitbucket.org' 'github.com' 'gitlab.com'; do
    ssh-keygen -R $host 1> /dev/null
    ssh-keyscan -t rsa $host | tee -a ~/.ssh/known_hosts
done
my_step_end

my_step_begin "make git respected xdg spec"
mkdir -p "$config_dir"

if [ -f $default_config_file ]; then
    mv $default_config_file "$config_file"
fi

my_create_file_if_not_exists "$config_file"
my_step_end

my_step_begin "create gitignore"
curl -sS https://www.gitignore.io/api/git,linux,jetbrains+all,sublimetext,virtualenv,visualstudiocode -o "$git_ignore_file"
echo -e "\n.tool-versions"| tee -a "$git_ignore_file"
git config --global core.excludesfile "$git_ignore_file"
my_step_end

my_step_begin "config git"
git config --global include.path "$ASSETS_DIR/git--config"
git config --global commit.template "$ASSETS_DIR/git--commit-template"
my_step_end

my_step_begin "config current repo"
git config core.filemode false
my_step_end
