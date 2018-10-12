#!/bin/bash

STEP="sysctl"
cp -R ./sysctl/. /etc/sysctl.d/
echo "done: $STEP"
