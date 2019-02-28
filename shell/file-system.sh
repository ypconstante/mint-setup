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
mkdir -p ~/projects/personal
mkdir -p ~/projects/sandbox
xdg-user-dirs-update --set TEMPLATES "$HOME/projects"
my_step_end

my_step_begin "create media folder"
mkdir ~/Media
rm -rf ~/Music
xdg-user-dirs-update --set MUSIC "$HOME/Media"
rm -rf ~/Pictures
xdg-user-dirs-update --set PICTURES "$HOME/Media"
rm -rf ~/Videos
xdg-user-dirs-update --set VIDEOS "$HOME/Media"
my_step_end

my_step_begin "make home folders lower case"
mv ~/Desktop   ~/desktop
mv ~/Documents ~/documents
mv ~/Downloads ~/downloads
mv ~/Media     ~/media
sed -Ei "s|\\\$HOME/(.)|\\\$HOME/\L\1|" "$XDG_CONFIG_HOME/user-dirs.dirs"
xdg-user-dirs-update
my_step_end

my_step_begin "create bookmark"
{
    echo "file://$HOME/documents Documents"
    echo "file://$HOME/downloads Downloads"
    echo "file://$HOME/projects Projects"
} > "$XDG_CONFIG_HOME/gtk-3.0/bookmarks"
my_step_end

my_step_begin "fix gnupg permissions"
mkdir -p ~/.gnupg
find ~/.gnupg -type d -exec chmod 700 {} \;
find ~/.gnupg -type f -exec chmod 600 {} \;
my_step_end

my_step_begin "temporary files only in memory"
sudo cp /usr/share/systemd/tmp.mount /etc/systemd/system/
sudo systemctl enable tmp.mount
my_step_end

my_step_begin "filesystem kernel parameters"
sudo cp "$ASSETS_DIR/file-system--kernel-parameters.conf" /etc/sysctl.d/98-file-system.conf
sudo chmod 644 /etc/sysctl.d/98-file-system.conf
my_step_end

my_step_begin "disable writing file access time"
sudo sed -Ei '/noatime/!s|(/ *\w* * [^ ]*)|\1,noatime|' /etc/fstab
my_step_end
