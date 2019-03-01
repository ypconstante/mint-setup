#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "close nemo"
nemo -q
my_step_end

my_step_begin "create base project structure"
mkdir -p ~/projects/personal
mkdir -p ~/projects/sandbox
my_step_end

my_step_begin "rename templates to projects"
xdg-user-dirs-update --set TEMPLATES "$HOME/projects"
rm -rf ~/Templates
my_step_end

my_step_begin "remove non used folders"
xdg-user-dirs-update --set DESKTOP "$(xdg-user-dir DOWNLOAD)"
rm -rf ~/Desktop
xdg-user-dirs-update --set PUBLICSHARE "$(xdg-user-dir DOWNLOAD)"
rm -rf ~/Public
my_step_end

my_step_begin "make home folders lower case"
mv ~/Documents ~/documents
mv ~/Downloads ~/downloads
mv ~/Music     ~/music
mv ~/Pictures  ~/pictures
mv ~/Videos    ~/videos
sed -Ei "s|\\\$HOME/(.)|\\\$HOME/\L\1|" "$XDG_CONFIG_HOME/user-dirs.dirs"
xdg-user-dirs-update
my_step_end

my_step_begin "create media folder"
mkdir -p ~/media
xdg-user-dirs-update --set MUSIC "$HOME/media"
rm -rf ~/music
xdg-user-dirs-update --set PICTURES "$HOME/media"
rm -rf ~/pictures
xdg-user-dirs-update --set VIDEOS "$HOME/media"
rm -rf ~/videos
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
