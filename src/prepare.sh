#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="remove unused packages"
apt autoremove -y -qq
my_apt_uninstall gimp
my_apt_uninstall gnome-accessibility-themes
my_apt_uninstall gnome-calendar
my_apt_uninstall gnome-orca
my_apt_uninstall hexchat
my_apt_uninstall mono-*
my_apt_uninstall ndiswrappe*
my_apt_uninstall pix
my_apt_uninstall rhythmbox*
my_apt_uninstall thunderbird
my_apt_uninstall xserver-xorg-video-intel
sudo rm -rf /usr/lib/mono
echo "done: $STEP"


STEP="remove asian fonts"
my_apt_uninstall \
	fonts-kacst* fonts-khmeros* fonts-lklug-sinhala fonts-guru-extra \
	fonts-nanum* fonts-noto-cjk fonts-takao* fonts-tibetan-machine fonts-lao \
	fonts-sil-padauk fonts-sil-abyssinica fonts-tlwg-* fonts-lohit-* \
	fonts-beng-extra fonts-gargi fonts-gubbi fonts-gujr-extra fonts-kalapi \
	fonts-lohit-* fonts-samyak* fonts-navilu fonts-nakula fonts-orya-extra \
	fonts-pagul fonts-sarai fonts-telu* fonts-wqy* fonts-smc* fonts-deva-extra
sudo dpkg-reconfigure fontconfig
echo "done: $STEP"

STEP="update packages"
apt clean -y -qq
apt update -y -qq
apt full-upgrade -y -qq
echo "done: $STEP"

STEP="create autostart folder"
mkdir -p ~/.config/autostart/
echo "done: $STEP"
