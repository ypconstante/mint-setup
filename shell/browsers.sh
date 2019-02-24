#!/bin/bash

source "$(dirname "$0")/_base.sh"

find . -name "browser_*.sh" -exec bash {} \;
