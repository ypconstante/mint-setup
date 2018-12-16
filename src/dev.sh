#!/bin/bash

source "$(dirname "$0")/_base.sh"

find . -name "dev_*.sh" -exec bash {} \;
