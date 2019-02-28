#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "close nemo"
nemo -q
my_step_end

my_step_begin "ignore folder view config"
dconf write /org/nemo/preferences/ignore-view-metadata true
my_step_end

my_step_begin "open files with single click"
dconf write /org/nemo/preferences/click-policy "'single'"
my_step_end

my_step_begin "edit executable text files when opened with nemo"
dconf write /org/nemo/preferences/executable-text-activation "'display'"
my_step_end

my_step_begin "configure nemo toolbar"
dconf write /org/nemo/preferences/show-open-in-terminal-toolbar true
# hide path mode toggle
dconf write /org/nemo/preferences/show-edit-icon-toolbar false
dconf write /org/nemo/preferences/show-search-icon-toolbar false
dconf write /org/nemo/preferences/show-compact-view-icon-toolbar false
my_step_end

my_step_begin "hide snaps folder"
echo snap >> ~/.hidden
my_step_end

my_step_begin "fix opening nemo from terminal"
sudo mkdir -p /var/lib/samba/usershares/
my_step_end
