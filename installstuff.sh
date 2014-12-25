#!/bin/bash

# Sources and stuff
sed -i 's/in.archive/archive/g' /etc/apt/sources.list

# Install essentials
apt-get -y install curl git cryptsetup zsh awesome rxvt-unicode-256color

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
apt-get -y install centerim irssi camorama exif testdisk elinks lynx

# Utilities
apt-get -y install bc units

# To list manually installed packages
# aptitude search '?installed ?not(?automatic)'

git config --global user.name "My name"
git config --global user.email "myemail@domain.com"
