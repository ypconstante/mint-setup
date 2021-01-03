#!/bin/bash

FORCE_RUN_AS_ROOT=1 source "$(dirname "$0")/_base.sh"
source /etc/os-release

set -euxo pipefail

os_install_id=''
os_partition_size=''
# os_root_partition_size='70G'
os_root_partition_size='100%FREE'

capitalized_os_install_id=$(echo $os_install_id | sed 's/[^ _-]*/\u&/g')
uefi_id="${PRETTY_NAME} ${capitalized_os_install_id}"

main_device_path='/dev/sda'
efi_partition_path='/dev/sda1'
main_partition_path='/dev/sda2'

main_vg='main_vg'
main_vg_os_boot="${os_install_id}_boot_lv"
main_vg_os_boot_path="/dev/mapper/${main_vg}-${main_vg_os_boot}"
main_vg_os="${os_install_id}_lv"
main_vg_os_path="/dev/mapper/${main_vg}-${main_vg_os}"

crypt_partition_name="${os_install_id}-crypt"
crypt_partition_path="/dev/mapper/${crypt_partition_name}"

os_vg="${os_install_id}_vg"
os_vg_root='root_lv'
os_vg_root_path="/dev/mapper/${os_vg}-${os_vg_root}"
os_vg_data='data_lv'
os_vg_data_path="/dev/mapper/${os_vg}-${os_vg_data}"

if [ -z "$os_install_id" ]; then
    my_echo_error "os_install_id is mandatory"
    exit 1
fi

if [ -z "$os_partition_size" ]; then
    my_echo_error "os_partition_size is mandatory"
    exit 1
fi

if [ -z "$os_root_partition_size" ]; then
    my_echo_error "os_root_partition_size is mandatory"
    exit 1
fi

setup_disk_partitions() {
    if [ -e $efi_partition_path ]; then
        echo 'disk partition already created, skipping'
        return 0
    fi

    sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk $main_device_path
    g # create a new GPT partition table
    ## boot efi partition
    n # new partition
    1 # partition number
      # default begin position
    +64M # partition size
    t # change type
    1 # efi
    ## main partition
    n # new partition
    2 # partion number
        # default begin position
        # default end position to end of disk
    p # print new partition table
    w # write partition table and exit
EOF

    mkfs.fat -F32 $efi_partition_path

    pvcreate $main_partition_path
    vgcreate $main_vg $main_partition_path
}

setup_main_partitions() {
    lvcreate --size 1G --name $main_vg_os_boot $main_vg
    mkfs -t ext4 $main_vg_os_boot_path

    lvcreate --size "$os_partition_size" --name $main_vg_os $main_vg

    vgchange -ay $main_vg
}

setup_crypt() {
    cryptsetup -v -y luksFormat $main_vg_os_path
    cryptsetup -v luksOpen $main_vg_os_path $crypt_partition_name
}

setup_os_partitions() {
    pvcreate $crypt_partition_path

    vgcreate $os_vg $crypt_partition_path

    lvcreate --extents "$os_root_partition_size" --name $os_vg_root $os_vg
    mkfs -t ext4 $os_vg_root_path
    # lvcreate --extents 100%FREE --name $os_vg_data $os_vg
}

run_install() {
    echo "
        installation config

        device:      $main_vg_os_boot_path
        mount point: /boot

        device:      $os_vg_root_path
        mount point: /

        device:      $os_vg_data_path
        mount point: /home
    "

    ubiquity
}

setup_os_startup() {
    mount /dev/${os_vg}/${os_vg_root} /mnt
    mount /dev/${main_vg}/${main_vg_os_boot} /mnt/boot
    mount $efi_partition_path /mnt/boot/efi

    main_vg_os_id="$(cryptsetup luksUUID ${main_vg_os_path})"

    content="${crypt_partition_name} UUID=${main_vg_os_id} none luks,discard"

    my_append_to_file_if_not_contains '/mnt/etc/crypttab' "$content"

    mount --bind /dev /mnt/dev

    chroot /mnt mount -t devpts devpts /dev/pts
    chroot /mnt mount -t proc proc /proc
    chroot /mnt mount -t sysfs sys /sys

    chroot /mnt update-initramfs -u -k all

    chroot /mnt grub-install --bootloader-id="$uefi_id" --no-uefi-secure-boot

    umount /mnt/boot/efi
    umount /mnt/boot
}

setup_disk_partitions
setup_main_partitions
setup_crypt
setup_os_partitions
run_install
setup_os_startup
