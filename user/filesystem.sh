#!/bin/bash

set -x

STEP="close nemo"
nemo -q
echo "done: $STEP"

STEP="remove non used folders"
rm -rf ~/Public
xdg-user-dirs-update
echo "done: $STEP"

STEP="rename templates to projects"
mv ~/Templates ~/Projects
sed -i 's/\$HOME\/Templates/\$HOME\/Projects/' ~/.config/user-dirs.dirs
xdg-user-dirs-update
echo "done: $STEP"

STEP="create media folder"
mkdir ~/Media
rm -rf ~/Videos
rm -rf ~/Music
rm -rf ~/Pictures
sed -i 's/\$HOME\/Music/\$HOME\/Media/' ~/.config/user-dirs.dirs
sed -i 's/\$HOME\/Pictures/\$HOME\/Media/' ~/.config/user-dirs.dirs
sed -i 's/\$HOME\/Videos/\$HOME\/Media/' ~/.config/user-dirs.dirs
xdg-user-dirs-update
echo "done: $STEP"

STEP="make home folders lower case"
mv ~/Desktop   ~/desktop
mv ~/Documents ~/documents
mv ~/Downloads ~/downloads
mv ~/Media     ~/media
mv ~/Projects  ~/projects
sed -i 's/\$HOME\/\(.\)/\$HOME\/\L\1/' ~/.config/user-dirs.dirs
xdg-user-dirs-update
echo "done: $STEP"

STEP="create bookmark"
: > ~/.config/gtk-3.0/bookmarks
echo "file://$HOME/documents Documents" >> ~/.config/gtk-3.0/bookmarks
echo "file://$HOME/downloads Downloads" >> ~/.config/gtk-3.0/bookmarks
echo "file://$HOME/projects Projects" >> ~/.config/gtk-3.0/bookmarks
echo "done: $STEP"

STEP="temporary files only in memory"
sudo cp /usr/share/systemd/tmp.mount /etc/systemd/system/
sudo systemctl enable tmp.mount
echo "done: $STEP"

STEP="filesystem kernel parameters"
sudo cp ./files/filesystem-sysctl.conf /etc/sysctl.d/98-filesystem.conf
echo "done: $STEP"
