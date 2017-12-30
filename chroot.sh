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

# Timezone, locale and keyboard settings
ln -f -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc --utc
echo $USER_LOCALE > /etc/locale.gen
locale-gen
echo "LANG=$LANG_VARIABLE" >> /etc/locale.conf
echo "KEYMAP=$KEYBOARD" >> /etc/vconsole.conf

# Services
systemctl enable sshd.service
systemctl enable dhcpcd.service
systemctl enable ntpd.service
systemctl enable vboxservice.service

# misc 
echo -e 'EDITOR=vim' > /etc/environment
echo -e 'runtime: archlinux.vim\nsyntax on' > /etc/skel/.vimrc

# Network huh
echo $HOSTNAME > /etc/hostname
useradd -m -G wheel -s /bin/bash $USERNAME
echo 'name_servers="8.8.8.8 8.8.4.4"' >> /etc/resolvconf.conf

# bootloader
grub-install --target=i386-pc --recheck /dev/sda
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# "SECURITY"
echo "$USERNAME:$PASSWORD" | chpasswd
echo "root:$ROOT_PASSWORD" | chpasswd
echo "FINISHED"

