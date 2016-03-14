#!/bin/zsh
## POST INSTALL CONFIGURATION

## Configure Internet using netctl. 
## Interface name from `ip link`
cp /etc/netctl/examples/ethernet-static /etc/netctl/
netctl start ethernet-static
netctl enable ethernet-static
# netctl switch-to different-network

sudo useradd -m -G wheel -s /bin/zsh eternaltyro
sudo passwd eternaltyro
Enter new UNIX password: somelongcompl3x$hi+
Retype new UINX password: samelongcompl3x$hi+
passwd: password updated successfully

##################################
### X.org Configuration
##################################
pacman -S xorg-xrdb (rendering Xresources)
pacman -S xorg-xrandr xorg-xkill
pacman -S xorg-server xorg-xinit xf86-input-synaptics

########################
# ZSH, Terminal and VIM 
########################
pacman -S awesome zsh slim slim-themes vicious
pacman -S rxvt-unicode rxvt-unicode-terminfo
pacman -S tmux vim-airline
#Z Shell is configured the first time user logs in
# Install `prezto-git` for Zsh customization

pacman -S alsa-utils moc vlc mpd mpc
pacman -S btrfs-progs snapper
pacman -S firefox chromium
pacman -S libreoffice-fresh
#rlwrap, dex, wireless_tools 

visudo
Cmnd_Alias    USER1 = /bin/kill, /usr/bin/pkill, /usr/bin/top, \
                      /sbin/halt, /sbin/reboot, /sbin/poweroff, \
                      /usr/bin/pacman, /usr/bin/vim, /usr/bin/vi, \
                      /usr/bin/systemct, /usr/bin/wifi-menu, /usr/bin/cryptsetup, \
                      /usr/bin/mount, /usr/bin/umount
myusername ALL=USER1

cp /etc/X11/xinit/xinitrc ~/.xinitrc	
vim /home/eternaltyro/.xinitrc

# Comment out the xterms and twm lines in the bottom and add awesome like so
setxkbmap dvorak
exec awesome

sudo vi /etc/slim.conf
sudo systemctl enable slim

## https://bbs.archlinux.org/viewtopic.php?id=120243

# If virtualbox guest, add virtualbox modules
# Errors starting X could be related to this

if grep hypervisor /proc/cpuinfo > /dev/null; then
    sudo pacman -S virtualbox-guest-utils
    sudo modprobe -a vboxguest vboxvideo vboxsf
fi

Only vboxvideo and vboxguest are important. vboxsf is for shared directories.

Fix SLiM Keyboard layout issue
==============================

# pacman -S xf86-input-evdev
# cat /etc/X11/xorg.conf.d/10-evdev.conf
Section "InputClass"
        Identifier "evdev keyboard catchall"
        MatchIsKeyboard "on"
        MatchDevicePath "/dev/input/event*"
        Driver "evdev"
        
        # Keyboard layouts
        Option "XkbLayout" “latam”
EndSection
https://bbs.archlinux.org/viewtopic.php?id=96634

xorg-xbacklight
# echo 5000 > /sys/class/backlight/intel_backlight/brightness
# cat /sys/class/backlight/intel_backlight/max_brightness
pacman -S xbindkeys
xbindkeys —defaults > /home/eternaltyro/.xbindkeysrc

# Install KeePassX
================
Download the AUR package for keepassx2 and `makepkg -sri` 

# Install Lain

# Download and install lain-git package from AUR

:() {
Updating Repos: pacman -Syy
Upgrading Packages: pacman -Su | pacman -Syu
Removing Packages: pacman -R
sudo pacman -Rsn $(pacman -Qdtq)
}

pacman -S wget
pacman -S gnucash

# Install Fonts
pacman -S ttf-dejavu ttf-anonymous-pro ttf-inconsolata
# Install ttf-tamil package from AUR
## Add infinality repository
pacman-key -r 962DDE58
pacman-key --lsign 962DDE58
cat <<'INFIN' >>/etc/pacman.conf
[infinality-bundle]
Server =  http://bohoomil.com/repo/$arch
INFIN

pacman -S infinality-bundle #(select default [all] for freetype, cairo 
#and fontconfig replacements)

pacman -S inkscape gimp
pacman -S ntfs-3g #or you can\'t write to NTFS devices
pacman -S jre8-openjdk icedtea-web

#######################################
### Virtualization and code deployment
#######################################
pacman -S virtualbox
modprobe vboxdrv
# VIRTUALBOX fix
# /sbin/rcvboxdrv setup
pacman -S vagrant docker lxc
systemctl enable docker
systemctl start docker

gem install rhc ## Openshift RedHat Client
rhc-setup
PATH=$PATH:/home/yogesh/.gem/ruby/2.2.0/bin

## Install heroku toolbelt
wget -O- https://toolbelt.heroku.com/install.sh | sh
PATH=$PATH:/usr/local/heroku/bin
# heroku-toolbelt (aur)

## Need to configure better on Arch. KVM package?
pacman -S qemu virt-manager

pacman -S cherrytree
pacman -S ibus ibus-m17n

###########################
### PYTHON PACKAGES
###########################
pacman -S python2 python2-pip ipython2-notebook
pip2.7 install jupyter
pip2.7 install requests
pip2.7 install ipython
pip2.7 install osmapi
pip2.7 install ipython
pip2.7 install geojson
pip2.7 install fastly
pip2.7 install scrapy

##########################################
# YUBIKEY
# Add UDEV rules for U2F token by YubiKey
##########################################
cat <<U2F >> /etc/udev/rules.d/45-u2f.rules
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0120", TAG+="uaccess"
U2F

########################################
# DOCKER 
# Add IP forwarding to fix container public routing issue
####################################
# cat >/etc/systemd/network/ipforward.network <<EOF
[Network]
IPForward=kernel
EOF

## Blacklist PC speaker to prevent system beeps
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
sudo rmmod pcspkr

## Document Readers
pacman -S zathura-pdf-poppler zathura-pdf-mupdf
pacman -S qpdf

google-talkplugin (aur)

pacman -S slock redshift
pacman -S clamav claws-mail claws-mail-themes
pacman -S ristretto shotwell fbreader tumbler
pacman -S nodejs npm
pacman -s mpc 
pacman -S dnsutils whois nmap gnu-netcat
pacman -S unzip
pacman -S dos2unix
pacman -S tree josm
pacman -S openldap
pacman -S hdparm strace dmidecode
pacman -S git bzr
pacman -S openvpn
pacman -S hunspell-en
pacman -S skype
pacman -S rdesktop
youtube-dl -U
pacman -S ansible
pacman -S putty

### ARDUINO PACKAGES
ardunio (AUR)
gnoduino (AUR)
