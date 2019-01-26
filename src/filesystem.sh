#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "close nemo"
nemo -q
my_step_end

my_step_begin "remove non used folders"
rm -rf ~/Public
xdg-user-dirs-update
my_step_end

my_step_begin "rename templates to projects"
rm -rf ~/Templates
sed -i 's/\$HOME\/Templates/\$HOME\/Projects/' $XDG_CONFIG_HOME/user-dirs.dirs
xdg-user-dirs-update
my_step_end

my_step_begin "create media folder"
mkdir ~/Media
rm -rf ~/Videos
rm -rf ~/Music
rm -rf ~/Pictures
sed -i 's/\$HOME\/Music/\$HOME\/Media/' $XDG_CONFIG_HOME/user-dirs.dirs
sed -i 's/\$HOME\/Pictures/\$HOME\/Media/' $XDG_CONFIG_HOME/user-dirs.dirs
sed -i 's/\$HOME\/Videos/\$HOME\/Media/' $XDG_CONFIG_HOME/user-dirs.dirs
xdg-user-dirs-update
my_step_end

my_step_begin "make home folders lower case"
mv ~/Desktop   ~/desktop
mv ~/Documents ~/documents
mv ~/Downloads ~/downloads
mv ~/Media     ~/media
sed -i 's/\$HOME\/\(.\)/\$HOME\/\L\1/' $XDG_CONFIG_HOME/user-dirs.dirs
xdg-user-dirs-update
my_step_end

my_step_begin "create bookmark"
: > $XDG_CONFIG_HOME/gtk-3.0/bookmarks
echo "file://$HOME/documents Documents" >> $XDG_CONFIG_HOME/gtk-3.0/bookmarks
echo "file://$HOME/downloads Downloads" >> $XDG_CONFIG_HOME/gtk-3.0/bookmarks
echo "file://$HOME/projects Projects" >> $XDG_CONFIG_HOME/gtk-3.0/bookmarks
my_step_end

my_step_begin "temporary files only in memory"
sudo cp /usr/share/systemd/tmp.mount /etc/systemd/system/
sudo systemctl enable tmp.mount
my_step_end

my_step_begin "filesystem kernel parameters"
sudo cp $ASSETS_DIR/filesystem--kernel-parameters.conf /etc/sysctl.d/98-filesystem.conf
sudo chmod 644 /etc/sysctl.d/98-filesystem.conf
my_step_end

my_step_begin "disable writing file access time"
sudo sed -i '/noatime/!s/\(\/ *\w* * [^ ]*\)/\1,noatime/' /etc/fstab
my_step_end
