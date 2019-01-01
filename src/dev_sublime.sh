#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "add sublime repository"
my_apt_add_key https://download.sublimetext.com/sublimehq-pub.gpg
my_apt_add_repository sublime "deb https://download.sublimetext.com/ apt/stable/"
my_step_end

my_step_begin "install sublime text"
my_apt_install sublime-text
my_step_end

my_step_begin "install sublime merge"
my_apt_install sublime-merge
my_step_end
