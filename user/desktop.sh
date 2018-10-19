#!/bin/bash

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
echo "done: $STEP"

STEP="modify background"
dconf write /org/cinnamon/desktop/background/picture-uri "'file:///usr/share/backgrounds/linuxmint-tara/whmii_toy_store.jpg'"
echo "done: $STEP"
