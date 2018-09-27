#!/bin/bash

STEP="increase amount of inotify watchers"
echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
echo "done: $STEP"
