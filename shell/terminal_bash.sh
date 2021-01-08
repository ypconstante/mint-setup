#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "remove unused bash files"
rm -f ~/.bash_history ~/.bash_logout
my_step_end
