#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "close nemo"
nemo -q
my_step_end

my_step_begin "set disabled nemo extensions"
dconf write /org/nemo/plugins/disabled-extensions "['ChangeFolderColor+NemoPython', 'EmblemPropertyPage+NemoPython', 'NemoShare']"
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

my_step_begin "configure nemo sidebar"
dconf write /org/nemo/window-state/sidebar-width 154
my_step_end

my_step_begin "configure previews"
dconf write /org/nemo/preferences/show-image-thumbnails "'local-only'"
dconf write /org/nemo/preferences/show-directory-item-counts "'never'"
my_step_end

my_step_begin "configure context menu"
dconf write /org/nemo/preferences/enable-delete false
dconf write /org/nemo/preferences/menu-config/selection-menu-scripts false
dconf write /org/nemo/preferences/menu-config/selection-menu-pin false
dconf write /org/nemo/preferences/menu-config/background-menu-scripts false
my_step_end

my_step_begin "set disabled nemo actions"
dconf write /org/nemo/plugins/disabled-actions "['new-launcher.nemo_action', 'set-as-background.nemo_action', 'add-desklets.nemo_action', 'change-background.nemo_action', 'send-by-mail.nemo_action']"
my_step_end

my_step_begin "fix opening nemo from terminal"
sudo mkdir -p /var/lib/samba/usershares/
my_step_end
