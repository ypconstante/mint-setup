#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install python build dependencies"
my_apt_install libbz2-dev
my_apt_install libreadline-dev
my_apt_install libsqlite3-dev
my_apt_install libssl-dev
my_apt_install python-openssl
my_apt_install zlib1g-dev
my_step_end


my_step_begin "init python plugin"
asdf list-all python 1> /dev/null
my_step_end

my_asdf_install_and_set_global python "$(asdf list-all python | grep '^3.9' | grep -v 'dev' | tail -1)"


export PIP_REQUIRE_VIRTUALENV=false

my_step_begin "update pip"
pip install --upgrade pip
my_step_end

my_step_begin "install ipython"
pip install --user ipython
my_step_end

my_step_begin "install virtual envs"
pip install --user pipenv
pip install --user virtualenv
my_step_end
