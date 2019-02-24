#!/bin/bash

source "$(dirname "$0")/_base.sh"

sublime_config_dir=$HOME/.config/sublime-text-3
package_control_file="$sublime_config_dir/Installed Packages/Package Control.sublime-package"
package_control_config_file="$sublime_config_dir/Packages/User/Package Control.sublime-settings"

my_step_begin "add sublime repository"
my_apt_add_key https://download.sublimetext.com/sublimehq-pub.gpg
my_apt_add_repository sublime "deb https://download.sublimetext.com/ apt/stable/"
my_step_end

my_step_begin "install sublime text"
my_apt_install sublime-text
my_step_end

my_step_begin "install package control"
mkdir -p "$(dirname "$package_control_file")"
curl -sSL "https://packagecontrol.io/Package Control.sublime-package" -o "$package_control_file"

mkdir -p "$(dirname "$package_control_config_file")"
my_link_file "$ASSETS_DIR/dev_sublime--package-control.sublime-settings" "$package_control_config_file"
my_step_end

my_step_begin "install sublime merge"
my_apt_install sublime-merge
my_step_end
