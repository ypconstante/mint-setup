#!/bin/bash

STEP="remove unused packages"
apt autoremove -y -qq
apt autoremove --purge -y -qq gimp
apt autoremove --purge -y -qq gnome-accessibility-themes
apt autoremove --purge -y -qq gnome-calendar
apt autoremove --purge -y -qq gnome-orca
apt autoremove --purge -y -qq hexchat
apt autoremove --purge -y -qq mono-*
apt autoremove --purge -y -qq ndiswrappe*
apt autoremove --purge -y -qq pix
apt autoremove --purge -y -qq rhythmbox*
apt autoremove --purge -y -qq thunderbird
apt autoremove --purge -y -qq xserver-xorg-video-intel
sudo rm -rf /usr/lib/mono
echo "done: $STEP"


STEP="remove asian fonts"
apt autoremove --purge -y -qq \
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
