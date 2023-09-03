#!/bin/zsh
# Arch Linux post-install configuration
#
# TODO: Add yay installation

""" --- DATE / TIME ---
"""
pacman -S ntp
ntpdate 0.arch.pool.ntp.org
systemctl start ntpd
systemctl enable ntpd

""" --- SECURITY ---
"""
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
yay -S ecryptfs-simple
sudo modprobe ecryptfs
pacman -S veracrypt

""" --- SECURITY AND HARDENING ---
"""
gufw
nftables
firejail
yay -S arch-audit
yay -S libfido2 # For SSH with Fido2 support
yay -S chkrootkit # Run: `chkrootkit`
tiger
wapiti

## RKHUNTER Optional Dependencies:
# - lsof
# - netstat
# - skdet - Simple rootkit detector

pacman -S rkhunter # Run: `rkhunter --skip-keypress --check`
pacman -S fail2ban # set enabled = true in jail.conf
gpg2 --keyserver hkps://hkps.pool.sks-keyservers.net:443 --recv-key 73AC9FC55848E977024D1A61429A566FD5B79251 # Import GPG key of security@cisofy.com
yay -S lynis # Run: `lynis audit system`

""" ___/security/vpn___
"""
wireguard
mullvad
yay -S mullvad-vpn
protonvpn

""" ___/security/password_managers___
"""
flatpak install --assumeyes --user "flathub" "com.bitwarden.desktop"
flatpak install --assumeyes --user "flathub" "org.keepassxc.KeePassXC"

""" ___/security/malware_handlers___
"""
yay -S clamtk clamav
yay -S maldet # sometimes outdated
# to run checks
# maldet -a /home

""" --- NETWORKING --- 
"""
## Configure Internet using netctl.
## Interface name from `ip link`
# cp /etc/netctl/examples/ethernet-static /etc/netctl/
# netctl start ethernet-static
# netctl enable ethernet-static
## netctl switch-to different-network
yay -S iwd
yay -S network-manager-applet

""" --- X.ORG CONFIGURATION ---
"""
yay -S xorg-xrdb (rendering Xresources)
yay -S xorg-xrandr xorg-xkill
yay -S xorg-server xorg-xinit xf86-input-synaptics
# TODO: Add synaptics config / libinput config
libinput-gestures

""" --- ZSH, TERMINAL, VIM ---

TODO: vim-fugitive, plugins, etc.
TODO: Explore alacritty circadian
"""
yay -S zsh tmux vim-airline
yay -S rxvt-unicode rxvt-unicode-terminfo
yay -S alacritty mosh terminator

""" --- WINDOW MANAGER / DESKTOP ENVIRONMENT ---
"""
yay -S awesome slim slim-themes vicious # - Dropped in favour of KDE Plasma + Wayland
#Z Shell is configured the first time user logs in
yay -S prezto-git  ## Zsh Customization

yay -S plasma-meta plasma-wayland-session plasma-wayland
yay -S rofi
yay -S flameshot # - Replaced with Spectacle 
yay -S kdeconnect

""" --- AUDIO / SOUND ---
"""

# ALSA: API for soundcard drivers; Part of the Kernel
#   closer to hardware
#
# PulseAudio: Sound Server works on top of ALSA
#   higher level APIs
#
# JACK is an alternative for professionals
#
# pacman -S alsa-utils # or...
""" Pulseaudio - Legacy audio driver
"""
# yay -S pulseaudio \
#        pavucontrol \
#        pulseaudio-bluetooth \
#        pulseeffects

""" Replace pulseaudio with pipewire
"""
yay -S pipewire-media-session \
	pipewire \
	pipewire-pulse
yay -S noisetorch


""" --- PERSONAL MEDIA MANAGEMENT ---
"""
yay -S vlc mpv kodi mplayer
yay -S shotwell
flatpak install --assumeyes --user "flathub" "org.kde.digikam"
gwenview
pacman -S ristretto tumbler      # - Thumbnailer service for ristretto
yay -S moc mpd mpc               # - Audio players
yay -S clementine qmmp audacious # - Audio players

yay -S wget wget2 aria2 # - Download utilities
yay -S brotli zstd      # - Compression algorithm support
yay -S peazip unrar p7zip unzip # - Compression utilities

"""__________ BACKUPS AND RECOVERY____________
"""
yay -S borg
flatpak install --assumeyes --user "flathub" "com.borgbase.Vorta"
yay -S dupeguru
yay -S snapper # helps make btrfs subvol snapshots
yay -S timeshift # Alternative to snapper
yay -S rclone
yay -S btrfs-progs exfatprogs xfsprogs f2fs-tools # - Filesystem programs
btrfs-compsize compsize btrfs-maintenance
# pacman -S ntfs-3g        ## NTFS devices write support (No-longer required?)
yay -S ntfs ntfs3-dkms

""" --- WEB BROWSERS ---
"""
yay -S lynx
flatpak install --assumeyes --user "flathub-beta" "org.mozilla.firefox"
flatpak install --assumeyes --user "flathub" "org.chromium.Chromium"
flatpak install --assumeyes --user "flathub" "com.github.Eloston.UngoogledChromium" # - Prefer over Brave?
flatpak install --assumeyes --user "flathub" "com.brave.Browser" # - Maybe not

flatpak install --assumeyes --user "flathub" "org.libreoffice.LibreOffice"
yay -S hunspell-en hyphen hunspell # - Spelling and punctuations; TODO: How do I let flatpak use these?

flatpak install --assumeyes --user "flathub" "org.gnucash.GnuCash"
yay -S perl-finance-quote # - TODO: How do I let flatpak GnuCash use this?
flatpak install --assumeyes --user "flathub" "net.giuspen.cherrytree"

yay -S ibus ibus-m17n  ## Indic language typing
yay -S qpdf zathura-pdf-poppler zathura-pdf-mupdf

yay -S fbreader      ## e-Book reader
yay -S dnsutils whois nmap gnu-netcat
yay -S tree
yay -S openldap
yay -S hdparm strace dmidecode

"""______ DEVELOPMENT AND WORK ______
"""
flatpak install --assumeyes --user "flathub-beta" "org.kde.kate"
flatpak install --assumeyes --user "flathub" "org.geany.Geany"
yay -S git bzr mercurial # - Distributed version control
yay -S meld
yay -S ansible
yay -S putty # - To help generate / transform Putty compatible SSH keys
# yay -S pgadmin4
# yay -S dbeaver

""" --- LANGUAGES ---
yay -S nodejs npm
yay -S rustup rust
"""

""" --- AWS Tools ---
yay -S aws-session-manager-plugin
yay -S aws-cli-v2-bin
"""
yay -S autopep8          # - Python auto-formatter for Kate
yay -S python-lsp-server # - Python Language Server Protocol server


""" --- GRAPHIC DESIGN STUFF ---
"""
flatpak install --assumeyes --user "flathub" "com.obsproject.Studio"
yay -S rawtherapee
flatpak install --assumeyes --user "flathub" "org.gimp.GIMP"         # - Raster editor
flatpak install --assumeyes --user "flathub" "org.inkscape.Inkscape" # Vector editor
yay -S openexr mozjpeg # - Image format support
# Download and install Xaviju's Inkscape Open Symbols
mkdir -p ~/.config/inkscape/symbols
git clone https://github.com/Xaviju/inkscape-open-symbols.git /tmp/
find /tmp/Xaviju/ -type f -name "*.svg" | xargs cp -t ~/.config/inkscape/symbols/

flatpak install --assumeyes --user "flathub" "org.openstreetmap.josm" # - OSM Editor

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


##________ KEYBOARD INPUT ________##
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
# KEYBOARD SHORTCUTS (INDEPENDENT OF WM)
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

yay -S light # Monitor backlight control

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

""" --- FONTS / TYPEFACES ---

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
- Noto fonts emoji
"""
#\\\ TERMINAL FONTS ///#
yay -S otf-fira-code otf-fira-mono otf-fira-sans


yay -S ttf-dejavu    # - Alternative to Bitstream Vera Sans
yay -S \
    ttf-bitstream-vera \
    noto-fonts-emoji \
    otf-openmoji \
    ttf-twemoji-color
# yay -S ttf-emojione-color ## Deprecated and superceded by twemoji

# yay -S ttf-joypixels ## Non-free
pacman -S \
    ttf-liberation \
    ttf-anonymous-pro \
    ttf-inconsolata \
    ttf-linux-libertine \
    ttf-linux-libertine-g \
    adobe-source-code-pro-fonts \ 
    adobe-source-sans-pro-fonts \
    adobe-source-serif-pro-fonts \
    noto-fonts \
    ttf-roboto

yay -S awesome-terminal-fonts
pacman -S font-mathematica
pacman -S powerline-fonts    ## Patched fonts to show powerline icons
yay -S tex-gyre-fonts
yay -S inter-font
yay -S otf-latin-modern ## Font default in LaTeX improved. 

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
yay -S virtualbox
modprobe vboxdrv
# VIRTUALBOX fix
# /sbin/rcvboxdrv setup
yay -S podman

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

pacman -S python-pip
pacman -S jupyter-notebook python-ipykernel ## ipython is a dependency

pip install requests
pip install ipython
pip install osmapi
pip install geojson
pip install fastly
pip install scrapy

##########################################
# YUBIKEY
# Add UDEV rules for U2F token by YubiKey
##########################################
cat <<U2F >> /etc/udev/rules.d/45-u2f.rules
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0120", TAG+="uaccess"
U2F

## UDEV FOR ENABLING TRIM ON SSD ##
# If SSD doesn't show non-zero bytes on `lsblk --discard` 
cat <<TRIM >> /etc/udev/rules.d/46-ssd-trim.rules
ACTION=="add|change", ATTRS{idVendor}=="<VENDOR_ID>", ATTRS{idProduct}=="<PRODUCT_ID>", SUBSYSTEM=="scsi_disk", ATTR{provisioning_mode}="unmap"
TRIM


## Blacklist PC speaker to prevent system beeps
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
sudo rmmod pcspkr



###########################
##________ COMMS ________##
###########################
gnupg2 --recv-keys 6feb6f83d48b3547
yay -S element-desktop

yay -S onionshare # Need PyQT5 library
yay -S jami-gnome jami-daemon
# aurman -S ricochet
# aurman -S zulip-desktop
# aurman -S rambox-bin
# yay -S retroshare
yay -S thunderbird-beta-bin thunderbird-beta-i18n-en-gb
pacman -S claws-mail claws-mail-themes    ## Mail Clients
yay -S slack
pacman -S mumble
yay -S tutanota-desktop-bin
yay -S signal-desktop-beta
yay -S teams zoom
yay -S jami
yay -S protonmail-bridge
dino
keybase

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
# bisq
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
yay -S intel-media-driver libva-intel-driver # For video acceleration
yay -S libva-utils
export LIBVA_DRIVER_NAME=iHD
vainfo
yay -S vulkan-info gpu-viewer

yay -S inxi               # System information tool
yay -S hardinfo
yay -S mesa-demos glmark2 # GPU benchmarking
# Figure out kernel modesetting

# File Manager
yay -S thunar thunar-archive-plugin thunar-media-tags-plugin
yay -S file-roller # Archive and unarchive frontend
yay -S nemo

# Bluetooth
yay -S bluez
yay -S blueman
yay -S android-udev
yay -S android-tools # For ADB
yay -S bluegriffon # For webdev

yay -S hw-probe
yay -S xournalpp
yay -S sshfs gvfs-smb # Navigate remote files via Thunar
yay -S leafpad
yay -S onlykey solo-python
yay -S stress
yay -S systemdgenie

"""__Mind maps"""
yay -S mindforger
yay -S xmind
yay -S vym

yay -S pandoc
# yay -S grafx2 # Old style bitmap graphics editor
yay -S clang
yay -S mpd  chromium ipython bind-tools avahi audit arandr
yay -S smbclient virt-manager virtualbox
yay -S handbrake
yay -S cdrtools cdrdao dvd+rw-tools cdparanoia
yay -S grsync # Sync input tools between multiple devices
# Just use KDE default DM - SDDM with breeze theme
# yay -S lightdm lightdm-webkit2-greeter lightdm-gtk-greeter
yay -S ccid acsccid pcsc-tools opensc
yay -S pkcs11 cryptoki
yay -S linux-zen
yay -S asp # AUR build packages - asp checkout element-desktop for example
yay -S udevil
yay -S filezilla
yay -S kalendar
yay -S android-file-transfer gvfs-mtp gvfs
yay -S n8n
yay -S sssd
yay -S calibre-web
yay -S opensnitch osquery
yay -S google-drive cryptomator
yay -S paperkey
yay -S sbsign sbutil
yay -S efitools
yay -S yara
yay -S sgx
yay -S unison

focalboard
polybar-git
bfg
ghostwriter
lepton
fawkes
fwupd
wine
powerdevil # KDE Power management
# https://clay-atlas.com/us/blog/2021/06/08/linux-en-upower-power-remaining/
upower # Battery information
pacman -S tlp # enable tlp.service
qgis
bleachbit
tzdata
voxel
dia
pencil
trebleshot
bashtop
arduino
tabula
asciinema
ncdu # ncurses du
libcastle 
pkimanager
pdftk
mime-info
pacman -S monero
pacman -S xmrig
pacman -S mymonero
nix
floor
# yay -S metabase
syncthing
nss
gnuradio
scrpy
seahorse
pacman -S bluegriffin # WYSIWYG Web editor
feh
dropbox

"""_________ GAMES __________
"""
surf
torcs
flightgear
supertuxkart
yay -S 0ad
endless-sky
cocaine
unvanquished
openra

"""______ FUN STUFF _______
"""
pacman -S stellarium
room-arranger
sweethome3d

""" --- FLATPAK APPS ---
"""
flatpak install --assumeyes --user "flathub" "ch.protonmail.protonmail-bridge"
flatpak install --assumeyes --user "flathub" "com.borgbase.Vorta"
flatpak install --assumeyes --user "flathub" "com.brave.Browser"
flatpak install --assumeyes --user "flathub" "com.calibre_ebook.calibre"
flatpak install --assumeyes --user "flathub" "com.github.johnfactotum.Foliate"
flatpak install --assumeyes --user "flathub" "com.github.tchx84.Flatseal"
flatpak install --assumeyes --user "flathub" "com.obsproject.Studio"
flatpak install --assumeyes --user "flathub" "com.play0ad.zeroad"
flatpak install --assumeyes --user "flathub" "com.slack.Slack"
flatpak install --assumeyes --user "flathub" "com.valvesoftware.Steam"
flatpak install --assumeyes --user "flathub" "im.riot.Riot"
flatpak install --assumeyes --user "flathub" "in.cinny.Cinny"
flatpak install --assumeyes --user "flathub" "io.github.wereturtle.ghostwriter"
flatpak install --assumeyes --user "flathub" "io.mpv.Mpv"
flatpak install --assumeyes --user "flathub" "io.podman_desktop.PodmanDesktop"
flatpak install --assumeyes --user "flathub" "net.giuspen.cherrytree"
flatpak install --assumeyes --user "flathub" "net.pioneerspacesim.Pioneer"
flatpak install --assumeyes --user "flathub" "org.audacityteam.Audacity"
flatpak install --assumeyes --user "flathub" "org.blender.Blender"
flatpak install --assumeyes --user "flathub" "org.cryptomator.Cryptomator"
flatpak install --assumeyes --user "flathub" "org.gaphor.Gaphor"
flatpak install --assumeyes --user "flathub" "org.gimp.GIMP"
flatpak install --assumeyes --user "flathub" "org.gnucash.GnuCash"
flatpak install --assumeyes --user "flathub" "org.inkscape.Inkscape"
flatpak install --assumeyes --user "flathub" "org.keepassxc.KeePassXC"
flatpak install --assumeyes --user "flathub-beta" "org.mozilla.firefox"
flatpak install --assumeyes --user "flathub" "org.qbittorrent.qBittorrent"
flatpak install --assumeyes --user "flathub-beta" "org.telegram.desktop"
flatpak install --assumeyes --user "flathub" "org.wesnoth.Wesnoth"
flatpak install --assumeyes --user "flathub" "org.zotero.Zotero"
flatpak install --assumeyes --user "flathub" "us.zoom.Zoom"

""" --- DEPRECATED ---

yay -S megasync-bin
yay -S vvawe
youtube-dl -U
# pacman -S laverna # - Note taking
pacman -S jre11-openjdk icedtea-web # - Probably only needed for JOSM
pacman -S slock dos2unix redshift # - Handled by KDE Plasma
ardunio (AUR)
gnoduino (AUR)
yay -S openvpn
yay -S rdesktop
"""

""" --- DEPRECATED DUE TO PODMAN / BUILDAH ---
pacman -S vagrant docker lxc
systemctl enable docker
systemctl start docker

# DOCKER: Add IP forwarding to fix container public routing issue
# cat >/etc/systemd/network/ipforward.network <<EOF
[Network]
IPForward=kernel
EOF
"""
