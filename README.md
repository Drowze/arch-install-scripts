## About
My set of scripts for setting up a development virtual machine (using VirtualBox) with Arch Linux

### On a fresh vm:
```bash
curl -L https://git.io/vbAmZ | tar -xz --strip-component=1
# change default variables in chroot.sh if desired
PASSWORD=example sh run.sh
reboot
```

### Default configuration:
```
HOSTNAME=homura
USERNAME=giba
ROOT_PASSWORD=<same to user password>
TIMEZONE=America/Sao_Paulo
USER_LOCALE="pt_BR.UTF-8 UTF-8"
KEYBOARD=br-abnt2
```

### What is installed?
```
base base-devel grub openssh sudo ntp exa \
fish tmux xsel git neovim htop virtualbox-guest-utils \
xorg-server xorg-xinit xterm openbox \
firefox
```

