#!/bin/bash

#######################################
## Strip Down Raspbian:
## - Remove many GUI related packages
## - Remove wolfram engine
## - Auto remove non-essentials
## 
## Kiosk-ify
## - Install & Config fbi splashscreen
## - Install uzbl lightweight browser
## - Install matchbox window manager
## - Install chromium-browser JIC
## - Install xdotool
## - Install nodm
########################################

apt-get install -y fbi uzbl matchbox chromium-browser xdotool
apt-get autoremove --purge wolfram-engine desktop-base lightdm lxappearance lxde-common lxde-icon-theme lxinput lxpanel lxpolkit lxrandr lxsession-edit lxshortcut lxtask lxterminal
#apt-get autoremove --purge lightdm lxde* 

cat <<EOF >>/home/pi/.xsession
#!/usr/bin/env bash
chromium-browser
EOF

cat <<'EOF' > /boot/cmdline.txt
dwc_otg.lpm_enable=0 console=ttyAMA0,115200 kgdboc=ttyAMA0,115200 console=tty4 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline rootwait logo.nologo loglevel=3
EOF

cat <<'EOF' > /etc/init.d/asplashscreen
#!/bin/bash
### BEGIN INIT INFO
# Provides:          asplashscreen
# Required-Start:
# Required-Stop:
# Should-Start:      
# Default-Start:     S
# Default-Stop:
# Short-Description: Show custom splashscreen
# Description:       Show custom splashscreen
### END INIT INFO


do_start () {

    /usr/bin/fbi -T 1 -noverbose -a /etc/splash.png    
    exit 0
}

case "$1" in
  start|"")
    do_start
    ;;
  restart|reload|force-reload)
    echo "Error: argument '$1' not supported" >&2
    exit 3
    ;;
  stop)
    # No-op
    ;;
  status)
    exit 0
    ;;
  *)
    echo "Usage: asplashscreen [start|stop]" >&2
    exit 3
    ;;
esac

:
EOF

chmod a+x /etc/init.d/asplashscreen
insserv /etc/init.d/asplashscreen
