#!/bin/zsh
## POST INSTALL CONFIGURATION

###############################
##________ DATE TIME ________##
###############################

pacman -S ntp
ntpdate 0.arch.pool.ntp.org
systemctl start ntpd
systemctl enable ntpd


##############################
##________ SECURITY ________##
##############################
visudo
Cmnd_Alias    USER1 = /bin/kill, /usr/bin/pkill, /usr/bin/top, \
                      /sbin/halt, /sbin/reboot, /sbin/poweroff, \
                      /usr/bin/pacman, /usr/bin/vim, /usr/bin/vi, \
                      /usr/bin/systemct, /usr/bin/wifi-menu, /usr/bin/cryptsetup, \
                      /usr/bin/mount, /usr/bin/umount
myusername ALL=USER1
sudo useradd -m -G wheel -s /bin/zsh eternaltyro
sudo passwd eternaltyro
Enter new UNIX password: somelongcompl3x$hi+
Retype new UINX password: samelongcompl3x$hi+
passwd: password updated successfully

gpg2 --recv-keys ec3cbe7f607d11e6
yay -S ecryptfs-simple # Do modprobe ecryptfs to be able to use this
pacman -S veracrypt

###
# PASSWORD MANAGERS
yay -S keepassxc
yay -S bitwarden-bin

################################
##________ NETWORKING ________##
################################
## Configure Internet using netctl.
## Interface name from `ip link`
cp /etc/netctl/examples/ethernet-static /etc/netctl/
netctl start ethernet-static
netctl enable ethernet-static
## netctl switch-to different-network

#########################################
##________ X.ORG CONFIGURATION ________##
#########################################
pacman -S xorg-xrdb (rendering Xresources)
pacman -S xorg-xrandr xorg-xkill
pacman -S xorg-server xorg-xinit xf86-input-synaptics
# TODO: Add synaptics config / libinput config

########################################
##________ ZSH, TERMINAL, VIM ________##
########################################
pacman -S zsh tmux vim-airline
pacman -S rxvt-unicode rxvt-unicode-terminfo

pacman -S awesome slim slim-themes vicious
#Z Shell is configured the first time user logs in
yay -S prezto-git  ## Zsh Customization

TODO: vim-fugitive, plugins, etc.

###################################
##________ AUDIO / SOUND ________##
###################################

# ALSA: API for soundcard drivers; Part of the Kernel
#   closer to hardware
#
# PulseAudio: Sound Server works on top of ALSA
#   higher level APIs
#
# JACK is an alternative for professionals
#
# pacman -S alsa-utils # or...
pacman -S pavucontrol

pacman -S moc mpd mpc    ## Audio players
pacman -S vlc mplayer    ## Video players
#yay -S pulseaudio-bluetooth
# Replace pulseaudio with pipewire
yay -S pipewire-pulse
yay -S clementine audacious


pacman -S btrfs-progs snapper # Snapper helps make btrfs subvol snapshots
pacman -S f2fs-tools 
pacman -S lynx firefox chromium    ## Browsers
pacman -S claws-mail claws-mail-themes    ## Mail Clients
pacman -S libreoffice-fresh hunspell-en
pacman -S gnucash
pacman -S cherrytree    ## Note taking

# DEAD
# pacman -S laverna       ## Note taking

pacman -S ibus ibus-m17n  ## Indic language typing
pacman -S qpdf zathura-pdf-poppler zathura-pdf-mupdf
pacman -S slock dos2unix unzip redshift wget
pacman -S shotwell digikam ristretto
pacman -S tumbler       ## Thumbnailer service for ristretto
pacman -S fbreader      ## e-Book reader
pacman -S nodejs npm
pacman -S dnsutils whois nmap gnu-netcat
pacman -S tree josm
pacman -S openldap
pacman -S hdparm strace dmidecode
pacman -S git bzr       ## Distributed version control
pacman -S openvpn
pacman -S rdesktop
youtube-dl -U
pacman -S ansible
pacman -S putty

##################################
##________ DESIGN STUFF ________##
##################################
pacman -S inkscape gimp  ## Raster and Vector graphics editor
# Download and install Xaviju's Inkscape Open Symbols
mkdir -p ~/.config/inkscape/symbols
git clone https://github.com/Xaviju/inkscape-open-symbols.git /tmp/
find /tmp/Xaviju/ -type f -name "*.svg" | xargs cp -t ~/.config/inkscape/symbols/



pacman -S josm           ## OpenStreetMap editor
pacman -S ntfs-3g        ## NTFS devices write support
pacman -S jre8-openjdk icedtea-web

#rlwrap, dex, wireless_tools 


################################
##________ LOGGING IN ________##
################################
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


####################################
##________ KEYBOARD INPUT ________##
####################################
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

###
# KEYBOARD SHORTCUTS (INDEPENDEND OF WM)
######
pacman -S xbindkeys
xbindkeys —defaults > /home/eternaltyro/.xbindkeysrc

# To figure out keys (type `q` to exit)
`xbindkeys -mk` then type keys
# Input into `.xbindkeysrc` file
`xbindkeys -p` to reload config

###
# DISPLAY 
######
# pacman -S xorg-xbacklight
# echo 5000 > /sys/class/backlight/intel_backlight/brightness
# cat /sys/class/backlight/intel_backlight/max_brightness

`sudo pacman -S light` # Monitor backlight control

###
# .xbindkeysrc config for brightness
######
```
"light -A 5"
  XF86MonBrightnessUp

"light -U 5"
  XF86MonBrightnessDown
```

###
# .xbindkeysrc config for volume controls
#
# TODO:
# - Switch from amixer to pactl
######
```
"amixer set Master 5%+"
  XF86AudioRaiseVolume

"amixer set Master 5%-"
  XF86AudioLowerVolume

"amixer set Master toggle"
  XF86AudioMute
```


:() {
Updating Repos: pacman -Syy
Upgrading Packages: pacman -Su | pacman -Syu
Removing Packages: pacman -R
sudo pacman -Rsn $(pacman -Qdtq)
}

"""          FONTS

Prefer OpenType fonts to TrueType fonts; OpenType fonts
support ligatures and font variations better esp. non-latin
characters.

Following fonts are installed:

- Arvo
- Renner
- Raleway
- Source-code-pro (Adobe)
- Source-sans-pro (Adobe)
- Source-serif-pro (Adobe)
- Linux Biolinum
- Linux Libertine
- Open Baskerville
- Inconsolata
- Fira Code (https://github.com/tonsky/FiraCode)
- Theano-Old-Style
- Meslo LG
- Lato
- Caladea
- Carlito
- Cormorant
- Inter
- Ligconsolata
- Overpass
- Roboto
- Public Sans
- Powerline Symbol
"""
#\\\ TERMINAL FONTS ///#
pacman -S otf-fira-code
pacman -S otf-fira-mono
pacman -S otf-fira-sans


pacman -S ttf-dejavu    ## Alternative to Bitstream Vera Sans
pacman -S ttf-liberation
pacman -S ttf-anonymous-pro
pacman -S ttf-inconsolata
pacman -S ttf-linux-libertine ttf-linux-libertine-g
pacman -S adobe-source-code-pro-fonts adobe-source-sans-pro-fonts
pacman -S adobe-source-serif-pro-fonts
pacman -S noto-fonts ttf-roboto
yay -S ttf-bitstream-vera
yay -S awesome-terminal-fonts
pacman -S font-mathematica
pacman -S powerline-fonts    ## Patched fonts to show powerline icons
# Install ttf-tamil package from AUR
## Add infinality repository
pacman-key -r 962DDE58
pacman-key --lsign 962DDE58
cat <<'INFIN' >>/etc/pacman.conf
[infinality-bundle]
Server =  http://bohoomil.com/repo/$arch
INFIN

pacman -S infinality-bundle # select default [all] for freetype, cairo 
                            # and fontconfig replacements)
# install public-sans OTF (https://github.com/uswds/public-sans)
yay -S otf-stix


"""     VIRTUALIZATION AND CODE DEPLOYMENT
!!!
"""
pacman -S virtualbox
modprobe vboxdrv
# VIRTUALBOX fix
# /sbin/rcvboxdrv setup
pacman -S vagrant docker lxc
systemctl enable docker
systemctl start docker

gem install rhc ## Openshift RedHat Client
rhc-setup
PATH=$PATH:/home/eternaltyro/.gem/ruby/2.2.0/bin

## Install heroku toolbelt
wget -O- https://toolbelt.heroku.com/install.sh | sh
PATH=$PATH:/usr/local/heroku/bin
# heroku-toolbelt (aur)

## Need to configure better on Arch. KVM package?
pacman -S qemu virt-manager

"""      PYTHON AND PYTHON LIBRARIES

Prefer `pacman -S` over `pip install` to avoid issues
"""

pacman -S python-pip python2-pip
pacman -S jupyter-notebook python2-ipykernel ## ipython is a dependency

pip2.7 install requests
pip2.7 install ipython
pip2.7 install osmapi
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


### ARDUINO PACKAGES
ardunio (AUR)
gnoduino (AUR)

###########################
##________ COMMS ________##
###########################
gnupg2 --recv-keys 6feb6f83d48b3547
yay -S element-desktop

# aurman -S retroshare
yay -S onionshare # Need PyQT5 library
yay -S jami-gnome jami-daemon
# aurman -S ricochet
# aurman -S zulip-desktop
# aurman -S rambox-bin

###################################
##________ LOOK AND FEEL ________##
###################################

# TODO: Add PS1 config
# TODO: Add lain and copycat-killer config for AwesomeWM
yay -S lain-git
yay -S awesome-freedesktop-git

## Configure Weather Widget in theme.lua
## OWM City ID for New Delhi - 1273840
## TODO: Keyboard shortcuts, screen brightness, volume, etc.

###########################################
##________ MONITORING MANAGEMENT ________##
###########################################
pacman -S htop

##
# EVALUATE
# ###

# Alvo
# Telegram
# Patchwork (secure scuttlebutt client ssb://)
# Lucidor - E-book reader?
# OpenBazaar
yay -S i2p
yay -S ipfs-desktop go-ipfs
yay -S webtorrent-desktop-bin

## Setting up PDF to open in Zathura
pacman -S xdg-utils
cat ~/.local/share/applications/zathura.desktop
```
[Desktop Entry]
Type=Application
Exec=/usr/bin/zathura %F
Comment=Open PDF files in Zathura via xdg-mime
```
xdg-mime default zathura.desktop application/pdf

### TODO
# - 7Zip install
# - Thunderbird Alpha / Beta
# - geany / geany-plugins
# - mpc / mpd / ncmpc setup
# - Vagrant / etc.
# - Steam

yay -S xbanish # Hides mouse pointer when typing;

###
# SSH Agent Config
######
# SSH-agent is not started automatically, create a systemd unit for
# the current user. Do not create for the root user

```
$ systemctl show --user --property=UnitPath
$ cat ~/.config/systemd/user.control/ssh-agent.service
[Unit]
Description=SSH key agent

[Service]
Type=simple
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
$ systemctl --user enable ssh-agent
$ systemctl --user start ssh-agent
$ tail -2 ~/.zshrc
SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket; export SSH_AUTH_SOCK;
SSH_AGENT_PID=$(/usr/bin/pgrep -xn ssh-agent); export SSH_AGENT_PID;
```

# ------------------ DEVICE DRIVERS -------------------------#
# While updating kernel, if you get the following errors:
# ==> WARNING: Possibly missing firmware for module: aic94xx
# ==> WARNING: Possibly missing firmware for module: wd719x
#-----------------------------------------------

yay -S aic94xx-firmware wd719x-firmware
# mkinitcpio -p  # optionally

# Installing Graphics Drivers
lspci | grep -e VGA
yay -S mesa vulkan-intel vulkan-icd-loader
yay -S xf86-video-intel   # Video drivers for intel
yay -S intel-media-driver # For video acceleration
yay -S libva-intel-driver
yay -S libva-utils
export LIBVA_DRIVER_NAME=iHD
vainfo
yay -S inxi               # System information tool
yay -S mesa-demos glmark2 # GPU benchmarking
# Figure out kernel modesetting


# Thunar
yay -S thunar thunar-archive-plugin thunar-media-tags-plugin
yay -S file-roller # Archive and unarchive frontend

# Bluetooth
yay -S bluez
yay -S blueman
yay -S unrar
yay -S android-udev
yay -S android-tools # For ADB
yay -S bluegriffon # For webdev

"""       SECURITY AND HARDENING
"""
yay -S arch-audit
yay -S libfido2 # For SSH with Fido2 support
yay -S chkrootkit tiger wapiti

yay -S maldet # sometimes outdated
# to run checks
# maldet -a /home

# Import GPG key of security@cisofy.com
gpg --keyserver hkps://hkps.pool.sks-keyservers.net:443 --recv-key 73AC9FC55848E977024D1A61429A566FD5B79251
yay -S lynis3
# To audit
# lynis audit system


yay -S hw-probe
yay -S thunderbird-beta-bin
yay -S xournalpp
yay -S sshfs gvfs-smb # Navigate remote files via Thunar
yay -S leafpad
yay -S onlykey
yay -S signal-desktop-beta
yay -S stress
yay -S systemdgenie
yay -S mullvad-vpn
yay -S mindforger
yay -S pandoc
yay -S grafx2
yay -S vorta borg
yay -S clang
yay -S 0ad
yay -S mpd meld openexr gnucash fail2ban electron chromium inkscape ipython bind-tools avahi audit arandr
yay -S smbclient virt-manager virtualbox youtube-dl xfsprogs
yay -S pgadmin4
yay -S handbrake
yay -S cdrtools cdrdao dvd+rw-tools cdparanoia
yay -S grsync # Sync input tools between multiple devices
yay -S exfatprogs
# Just use KDE default DM - SDDM with breeze theme
# yay -S lightdm lightdm-webkit2-greeter lightdm-gtk-greeter
yay -S perl-finance-quote
yay -S ccid acsccid pcsc-tools opensc solo-python
yay -S linux-zen
yay -S obs-studio
yay -S node
yay -S asp # AUR build packages - asp checkout element-desktop for example
yay -S flameshot
yay -S protonmail-bridge
yay -S plasma-meta plasma-wayland-session
yay -S alacritty-git mosh terminator
yay -S rofi
yay -S fwupd # Firmware updates

