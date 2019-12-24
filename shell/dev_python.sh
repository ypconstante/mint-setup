#!/bin/bash

source "$(dirname "$0")/_base.sh"

# python is installed using asdf

my_step_begin "install packages usually needed by python packages"
my_apt_install build-essential gcc g++ make
my_step_end

my_step_begin "install virtual envs"
export PIP_REQUIRE_VIRTUALENV=false
pip install --user pipenv
pip install --user virtualenv
my_step_end

my_step_begin "update conda"
conda update conda -y
conda update --all -y
my_step_end
