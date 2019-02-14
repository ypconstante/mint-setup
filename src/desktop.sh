#!/bin/bash

source "$(dirname "$0")/_base.sh"

APPLET_ID=42
MENU_CONFIG_FILE=~/.cinnamon/configs/menu@cinnamon.org/$APPLET_ID.json

my_step_begin "hide desktop icons"
dconf write /org/nemo/desktop/home-icon-visible false
dconf write /org/nemo/desktop/computer-icon-visible false
dconf write /org/nemo/desktop/volumes-visible false
my_step_end

my_step_begin "change theme"
dconf write /org/cinnamon/desktop/wm/preferences/theme "'Mint-Y-Dark'"
dconf write /org/cinnamon/desktop/interface/gtk-theme "'Mint-Y-Darker'"
dconf write /org/cinnamon/theme/name "'Mint-Y'"
my_step_end

my_step_begin "modify taskbar"
# position
dconf write /org/cinnamon/panels-enabled "['1:0:right']"
# size
dconf write /org/cinnamon/panels-resizable "['1:true']"
dconf write /org/cinnamon/panels-height "['1:40']"
# don't scale text
dconf write /org/cinnamon/panels-scale-text-icons "['1:false']"
# taskbar elements
dconf write /org/cinnamon/enabled-applets "[
 'panel1:left:0:menu@cinnamon.org:$APPLET_ID',
 'panel1:left:3:window-list@cinnamon.org:$APPLET_ID',
 'panel1:right:0:workspace-switcher@cinnamon.org:$APPLET_ID',
 'panel1:right:1:systray@cinnamon.org:$APPLET_ID',
 'panel1:right:2:network@cinnamon.org:$APPLET_ID',
 'panel1:right:3:sound@cinnamon.org:$APPLET_ID',
 'panel1:right:4:power@cinnamon.org:$APPLET_ID',
 'panel1:right:5:notifications@cinnamon.org:$APPLET_ID',
 'panel1:right:6:calendar@cinnamon.org:$APPLET_ID'
]"
# hide taskbar
dconf write /org/cinnamon/panels-autohide "['1:intel']"
my_step_end

my_step_begin "modify background"
dconf write /org/cinnamon/desktop/background/picture-uri "'file:///usr/share/backgrounds/linuxmint-tara/whmii_toy_store.jpg'"
my_step_end

my_step_begin "modify windows"
dconf write /org/cinnamon/desktop/wm/preferences/button-layout "':minimize,close'"
dconf write /org/cinnamon/desktop/wm/preferences/focus-mode "'sloppy'"
dconf write /org/cinnamon/desktop/wm/preferences/auto-raise false
my_step_end

my_step_begin "modify alt tab switcher"
dconf write /org/cinnamon/alttab-switcher-style "'icons+preview'"
dconf write /org/cinnamon/alttab-minimized-aware true
dconf write /org/cinnamon/alttab-switcher-enforce-primary-monitor true
my_step_end

my_step_begin "change menu config"
my_wait_file $MENU_CONFIG_FILE
cat $MENU_CONFIG_FILE \
	| jq 'setpath(["search-filesystem", "value"]; true)' \
	| jq 'setpath(["menu-icon-custom", "value"]; true)' \
	| jq 'setpath(["menu-icon", "value"]; "'$ASSETS_DIR'/desktop--menu-icon.svg")' \
	| sponge $MENU_CONFIG_FILE
my_step_end
