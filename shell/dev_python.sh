#!/bin/bash

source "$(dirname "$0")/_base.sh"

# python is installed using asdf

my_step_begin "install virtual envs"
pip install --user pipenv
pip install --user virtualenv
my_step_end

my_step_begin "update conda"
conda update conda -y
conda update --all -y
my_step_end
