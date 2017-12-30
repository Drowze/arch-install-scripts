#!/bin/sh

echo 'Loaded chroot.sh'

HOSTNAME=homura
USERNAME=giba
PASSWORD=$PASSWORD
ROOT_PASSWORD=$PASSWORD
TIMEZONE=America/Sao_Paulo
USER_LOCALE="pt_BR.UTF-8 UTF-8"
LANG_VARIABLE=pt_BR.UTF-8
KEYBOARD=br-abnt2

grub-install --target=i386-pc --recheck /dev/sda
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable sshd.service
systemctl enable dhcpcd.service
systemctl enable ntpd.service

echo -e 'EDITOR=vim' > /etc/environment
echo -e 'runtime: archlinux.vim\nsyntax on' > /etc/skel/.vimrc

echo $HOSTNAME > /etc/hostname
useradd -m -G wheel -s /bin/bash $USERNAME 

ln -f -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc --utc
echo $USER_LOCALE > /etc/locale.gen
locale-gen
LANG=$LANG_VARIABLE
localectl set-keymap --no-convert $KEYBOARD

echo 'name_servers="8.8.8.8 8.8.4.4"' >> /etc/resolvconf.conf

echo "$USERNAME:$PASSWORD" | chpasswd
echo "root:$ROOT_PASSWORD" | chpasswd
echo "FINISHED"

