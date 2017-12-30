#!/bin/sh

SCRIPT_DIR=/root/scripts

timedatectl set-ntp true
parted -s /dev/sda mklabel msdos
parted -s -a optimal /dev/sda mkpart primary ext4 0% 100%
parted -s /dev/sda set 1 boot on
mkfs.ext4 -F /dev/sda1
mount /dev/sda1 /mnt
pacman -Syy

mkdir -p /mnt$SCRIPT_DIR
mv ./chroot.sh /mnt$SCRIPT_DIR

pacstrap /mnt base base-devel grub openssh sudo ntp
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt /bin/bash $SCRIPT_DIR/chroot.sh

