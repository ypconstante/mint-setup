#!/bin/bash

source "$(dirname "$0")/_base.sh"

find . -name "package_*.sh" -exec bash {} \;
