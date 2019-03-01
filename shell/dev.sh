#!/bin/bash

source "$(dirname "$0")/_base.sh"

find . -name "dev_*.sh" -not -name "dev_asdf*" -exec bash {} \;
./dev_asdf.sh
./dev_asdf-packages.sh
