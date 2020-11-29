#!/bin/bash

source "$(dirname "$0")/_base.sh"

./dev_asdf.sh
./dev_asdf-packages.sh
find . -name "dev_*.sh" -not -name "dev_asdf*" -print0 | my_run_files
