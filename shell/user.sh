#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "ask password on login"
sudo gpasswd -d "$USER" nopasswdlogin &> /dev/null
sudo sed -Ei '/^autologin-user=/d' /etc/lightdm/lightdm.conf
sudo sed -Ei 's/^autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
my_step_end
