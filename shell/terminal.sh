#!/bin/bash

source "$(dirname "$0")/_base.sh"

find . -name "terminal_*.sh" -print0 | my_run_files
