#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "modify update manager settings"
dconf write /com/linuxmint/updates/hide-window-after-update true
dconf write /com/linuxmint/updates/hide-systray true
dconf write /com/linuxmint/updates/default-repo-is-ok true
dconf write /com/linuxmint/updates/kernel-updates-are-safe false
my_step_end
