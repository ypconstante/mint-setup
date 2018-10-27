#!/bin/bash

set -x

find . -name "package_*.sh" -exec bash {} \;
