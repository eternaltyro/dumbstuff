#!/bin/bash

# Sources and stuff
#sed -i 's/in.archive/archive/g' /etc/apt/sources.list

pacman -S --noconfirm firefox
pacman -S --noconfirm git
pacman -S --noconfirm ttf-indic-otf
pacman -S --noconfirm zsh
pacman -S --noconfirm cryptsetup
pacman -S --noconfirm ecryptfs-utils
pacman -S --noconfirm awesome
pacman -S --noconfirm rtorrent
pacman -S --noconfirm xfce4
pacman -S --noconfirm rxvt-unicode
pacman -S --noconfirm lynx
pacman -S --noconfirm irssi


# Install essentials
pacman -S install curl

# Install security packages
apt-get -y install fslint secure-delete bleachbit chkrootkit etherape rkhunter unhide

# Install entertainment packages
apt-get -y install moc audacious vlc mpd

# Install graphical packages 
apt-get -y install gimp inkscape libreoffice zathura darktable

# Install Dev packages
apt-get -y install ipython

# Virt packages
apt-get -y install kvm virt-manager virtualbox-ose

# Other packages
apt-get -y install centerim camorama exif testdisk elinks

# Utilities
apt-get -y install bc units

# To list manually installed packages
# aptitude search '?installed ?not(?automatic)'

git config --global user.name "My name"
git config --global user.email "myemail@domain.com"
