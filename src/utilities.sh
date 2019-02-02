#!/bin/bash

source "$(dirname "$0")/_base.sh"

find . -name "utility_*.sh" -exec bash {} \;
