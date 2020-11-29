#!/bin/bash

source "$(dirname "$0")/_base.sh"

find . -name "browser_*.sh" -print0 | my_run_files
