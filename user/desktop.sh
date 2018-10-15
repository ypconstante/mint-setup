#!/bin/bash

STEP="hide desktop icons"
dconf write /org/nemo/desktop/home-icon-visible false
dconf write /org/nemo/desktop/computer-icon-visible false
dconf write /org/nemo/desktop/volumes-visible false
echo "done: $STEP"

STEP="modify taskbar"
# position
gsettings set org.cinnamon panels-enabled "['1:0:right']"
# size
gsettings set org.cinnamon panels-resizable "['1:true']"
gsettings set org.cinnamon panels-height "['1:40']"
# don't scale text
gsettings set org.cinnamon panels-scale-text-icons "['1:false']"
# taskbar elements
gsettings set org.cinnamon enabled-applets "[
 'panel1:left:0:menu@cinnamon.org:1',
 'panel1:left:3:window-list@cinnamon.org:4',
 'panel1:right:0:systray@cinnamon.org:0',
 'panel1:right:2:network@cinnamon.org:9',
 'panel1:right:3:sound@cinnamon.org:13',
 'panel1:right:4:power@cinnamon.org:11',
 'panel1:right:5:notifications@cinnamon.org:6',
 'panel1:right:6:calendar@cinnamon.org:12'
]"
echo "done: $STEP"

STEP="modify background"
gsettings set org.cinnamon.desktop.background picture-uri "'file:///usr/share/backgrounds/linuxmint-tara/whmii_toy_store.jpg'"
echo "done: $STEP"
