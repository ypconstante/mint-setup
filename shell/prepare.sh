#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "remove unused packages"
sudo apt autoremove -y -qq
my_apt_uninstall gnome-accessibility-themes
my_apt_uninstall gnome-calendar
my_apt_uninstall gnome-orca
my_apt_uninstall hexchat
my_apt_uninstall mintwelcome
my_apt_uninstall mono-*
my_apt_uninstall ndiswrappe*
my_apt_uninstall pix
my_apt_uninstall rhythmbox*
my_apt_uninstall thunderbird
my_apt_uninstall xserver-xorg-video-intel
sudo rm -rf /usr/lib/mono
my_step_end

my_step_begin "update packages"
sudo apt clean -y -qq
sudo apt update -y -qq
sudo apt full-upgrade -y -qq
sudo apt autoremove -y -qq
flatpak update
my_step_end

my_step_begin "create common folders"
mkdir -p "$XDG_CONFIG_HOME/autostart/"
mkdir -p "$HOME/.local/bin/"
mkdir -p "$XDG_DATA_HOME/applications"
my_step_end
