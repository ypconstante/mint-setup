#!/bin/bash

source "$(dirname "$0")/_base.sh"

MENU_CONFIG_FILE=$(find ~/.cinnamon/configs/menu@cinnamon.org -name '*.json' -exec ls -1t "{}" + | head -n 1)

STEP="hide desktop icons"
dconf write /org/nemo/desktop/home-icon-visible false
dconf write /org/nemo/desktop/computer-icon-visible false
dconf write /org/nemo/desktop/volumes-visible false
echo "done: $STEP"

STEP="change theme"
dconf write /org/cinnamon/desktop/wm/preferences/theme "'Mint-Y-Dark'"
dconf write /org/cinnamon/desktop/interface/gtk-theme "'Mint-Y-Darker'"
dconf write /org/cinnamon/theme/name "'Mint-Y'"
echo "done: $STEP"

STEP="modify taskbar"
# change menu icon
mkdir -p ~/.var/icons
cp $ASSETS/desktop--menu-icon.svg ~/.var/icons/menu.svg
perl -i -p0e 's/("menu-icon-custom":.*?"value": ?)[^\n,]*/$1."true"/se' $MENU_CONFIG_FILE
perl -i -p0e 's/("menu-icon":.*?"value": ?)[^\n,]*/$1."\"'"${HOME//\//\\/}"'\/.var\/icons\/menu.svg\""/se' $MENU_CONFIG_FILE
echo "done: $STEP"

STEP="allow path in menu search"
perl -i -p0e 's/("search-filesystem":.*?"value": ?)[^\n,]*/$1."true"/se' $MENU_CONFIG_FILE

# position
dconf write /org/cinnamon/panels-enabled "['1:0:right']"
# size
dconf write /org/cinnamon/panels-resizable "['1:true']"
dconf write /org/cinnamon/panels-height "['1:40']"
# don't scale text
dconf write /org/cinnamon/panels-scale-text-icons "['1:false']"
# taskbar elements
dconf write /org/cinnamon/enabled-applets "[
 'panel1:left:0:menu@cinnamon.org',
 'panel1:left:3:window-list@cinnamon.org',
 'panel1:right:0:workspace-switcher@cinnamon.org',
 'panel1:right:1:systray@cinnamon.org',
 'panel1:right:2:network@cinnamon.org',
 'panel1:right:3:sound@cinnamon.org',
 'panel1:right:4:power@cinnamon.org',
 'panel1:right:5:notifications@cinnamon.org',
 'panel1:right:6:calendar@cinnamon.org'
]"
# hide taskbar
dconf write /org/cinnamon/panels-autohide "['1:intel']"
echo "done: $STEP"

STEP="modify background"
dconf write /org/cinnamon/desktop/background/picture-uri "'file:///usr/share/backgrounds/linuxmint-tara/whmii_toy_store.jpg'"
echo "done: $STEP"

STEP="modify windows"
dconf write /org/cinnamon/desktop/wm/preferences/button-layout "':minimize,close'"
dconf write /org/cinnamon/desktop/wm/preferences/focus-mode "'sloppy'"
dconf write /org/cinnamon/desktop/wm/preferences/auto-raise false
echo "done: $STEP"

STEP="modify alt tab switcher"
dconf write /org/cinnamon/alttab-switcher-style "'icons+preview'"
dconf write /org/cinnamon/alttab-minimized-aware true
dconf write /org/cinnamon/alttab-switcher-enforce-primary-monitor true
echo "done: $STEP"
