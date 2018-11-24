#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="close nemo"
nemo -q
echo "done: $STEP"

STEP="ignore folder view config"
dconf write /org/nemo/preferences/ignore-view-metadata true
echo "done: $STEP"

STEP="open files with single click"
dconf write /org/nemo/preferences/click-policy "'single'"
echo "done: $STEP"

STEP="configure nemo toolbar"
dconf write /org/nemo/preferences/show-open-in-terminal-toolbar true
# hide path mode toggle
dconf write /org/nemo/preferences/show-edit-icon-toolbar false
dconf write /org/nemo/preferences/show-search-icon-toolbar false
dconf write /org/nemo/preferences/show-compact-view-icon-toolbar false
echo "done: $STEP"

STEP="hide snaps folder"
echo snap >> ~/.hidden
echo "done: $STEP"
