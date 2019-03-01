#!/bin/bash

source "$(dirname "$0")/_base.sh"

menu_applet_id=42
menu_config_file=~/.cinnamon/configs/menu@cinnamon.org/$menu_applet_id.json

my_step_begin "hide desktop icons"
dconf write /org/nemo/desktop/desktop-layout "'false::false'"
# still used by nemo to define if desktop will be shown in nemo's sidebar
dconf write /org/nemo/desktop/show-desktop-icons false
my_step_end

my_step_begin "change theme"
dconf write /org/cinnamon/desktop/wm/preferences/theme "'Mint-Y-Dark'"
dconf write /org/cinnamon/desktop/interface/gtk-theme "'Mint-Y-Darker'"
dconf write /org/cinnamon/desktop/interface/icon-theme "'Mint-Y'"
dconf write /org/cinnamon/theme/name "'Mint-Y-Dark'"
my_step_end

my_step_begin "modify taskbar"
# position
dconf write /org/cinnamon/panels-enabled "['1:0:right']"
# size
dconf write /org/cinnamon/panels-height "['1:40']"
dconf write /org/cinnamon/panel-zone-icon-sizes "'[{\"panelId\": 1, \"left\": 0, \"center\": 0, \"right\": 22}]'"
dconf write /org/cinnamon/theme/symbolic-relative-size 0.75
# taskbar elements
dconf write /org/cinnamon/enabled-applets "[
 'panel1:left:0:menu@cinnamon.org:$menu_applet_id',
 'panel1:left:10:grouped-window-list@cinnamon.org',
 'panel1:right:0:workspace-switcher@cinnamon.org',
 'panel1:right:5:spacer@cinnamon.org',
 'panel1:right:10:systray@cinnamon.org',
 'panel1:right:20:network@cinnamon.org',
 'panel1:right:30:sound@cinnamon.org',
 'panel1:right:40:power@cinnamon.org',
 'panel1:right:50:notifications@cinnamon.org',
 'panel1:right:60:calendar@cinnamon.org'
]"
# hide taskbar
dconf write /org/cinnamon/panels-autohide "['1:intel']"
my_step_end

my_step_begin "modify background"
dconf write /org/cinnamon/desktop/background/picture-uri "'file:///usr/share/backgrounds/linuxmint-tara/whmii_toy_store.jpg'"
dconf write /org/cinnamon/desktop/background/picture-options "'zoom'"
my_step_end

my_step_begin "modify windows"
dconf write /org/cinnamon/desktop/wm/preferences/button-layout "':minimize,close'"
dconf write /org/cinnamon/desktop/wm/preferences/focus-mode "'click'"
dconf write /org/cinnamon/prevent-focus-stealing true
my_step_end

my_step_begin "modify alt tab switcher"
dconf write /org/cinnamon/alttab-switcher-style "'icons+preview'"
dconf write /org/cinnamon/alttab-minimized-aware true
dconf write /org/cinnamon/alttab-switcher-enforce-primary-monitor true
my_step_end

my_step_begin "change menu config"
my_wait_file $menu_config_file
jq 'setpath(["search-filesystem", "value"]; true)' < "$menu_config_file" \
    | jq 'setpath(["menu-custom", "value"]; true)' \
    | jq 'setpath(["menu-label", "value"]; "")' \
    | jq 'setpath(["menu-icon", "value"]; "'"$ASSETS_DIR"'/desktop--menu-icon.svg")' \
    > "$menu_config_file.tmp"
mv "$menu_config_file.tmp" "$menu_config_file"
my_step_end
