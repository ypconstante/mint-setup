#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install zsh"
my_apt_install zsh
my_step_end

my_step_begin "install zgen"
my_git_clone https://github.com/tarjoilija/zgen.git $ZDOTDIR/zgen
my_step_end

my_step_begin "configure zsh"
my_append_to_file_if_not_contains /etc/shells $(which zsh)
sudo chsh -s $(which zsh) $USER
sed 's/^export \([^=]*\)/\1 DEFAULT/g' $ASSETS_DIR/base--env > ~/.pam_environment
my_link_file $ASSETS_DIR/base--env $ZDOTDIR/.zshenv
my_link_file $ASSETS_DIR/terminal.zshrc $ZDOTDIR/.zshrc
my_step_end

my_step_begin "install zsh plugins"
zsh -i -c true
my_step_end
