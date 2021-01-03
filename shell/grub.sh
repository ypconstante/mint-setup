#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install grub theme"
theme_config=/boot/grub/themes/linuxmint/theme.txt

efi_id=$(efibootmgr -v | grep BootCurrent | awk '{print $2}')
efi_label=$(efibootmgr -v | grep "Boot${efi_id}" | awk '{print $2}')

my_apt_install grub2-theme-mint --reinstall -o Dpkg::Options::="--force-confmiss"
my_append_to_file_if_not_contains $theme_config "title-text: \"${efi_label}\""
my_append_to_file_if_not_contains $theme_config "title-color: \"#ffffff\""
sudo update-grub
my_step_end
