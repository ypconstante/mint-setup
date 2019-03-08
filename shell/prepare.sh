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


my_step_begin "remove asian fonts"
my_apt_uninstall \
    fonts-kacst* fonts-khmeros* fonts-lklug-sinhala fonts-guru-extra \
    fonts-nanum* fonts-noto-cjk fonts-takao* fonts-tibetan-machine fonts-lao \
    fonts-sil-padauk fonts-sil-abyssinica fonts-tlwg-* fonts-lohit-* \
    fonts-beng-extra fonts-gargi fonts-gubbi fonts-gujr-extra fonts-kalapi \
    fonts-lohit-* fonts-samyak* fonts-navilu fonts-nakula fonts-orya-extra \
    fonts-pagul fonts-sarai fonts-telu* fonts-wqy* fonts-smc* fonts-deva-extra
sudo dpkg-reconfigure fontconfig
my_step_end

my_step_begin "update packages"
sudo apt clean -y -qq
sudo apt update -y -qq
sudo apt full-upgrade -y -qq
sudo apt autoremove -y -qq
my_step_end

my_step_begin "create common folders"
mkdir -p "$XDG_CONFIG_HOME/autostart/"
mkdir -p "$HOME/.local/bin/"
mkdir -p "$XDG_DATA_HOME/applications"
my_step_end
