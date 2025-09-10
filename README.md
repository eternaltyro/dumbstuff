Dumb Scripts
============

A repository of scripts to do everyday tasks and some advanced tasks.. I would be very VERRRY careful using these for anything serious. You've been warned.

List of scripts here:
---------------------

+ Ubuntu_dl Script to download the latest nightly build of an Ubuntu distro
+ aws_vpn_linux_cgw.sh Script to set up a Linux instance as a Customer Gateway for Amazon AWS VPN 
+ build_alljoyn.sh A desperate attempt to prepare RaspberryPi for compiling AllJoyn source
+ firewall.rules Simple IPtables Firewall Rules
+ harden.sh Attempt to scritify simple system hardening.
+ installstuff.sh Script to prep new personal systems
+ ...

# TODO: Selfhosted Setup

- Mealie
- Calibre Web
- Jellyfin
- Vaultwarden

## TODO: SYSTEM SETUP

- Move away from mkinitcpio to dracut or booster
- Move mkinitcpio hooks to Systemd
    - udev -> systemd
    - keymap consolefont -> sd-vconsole
    - encrypt -> sd-encrypt
- Enable FIDO2 unlock for dm-crypt devices
- Attempt a move from iwctl to networkctl (WiFi, VPN, DoH/DoT, IPv6 extensions)
- Smart card login
- Fingerprint setup + PAM using fingwit (or alternatives)
- TPM2 keys
- Podman systemd unit

## TODO: REPO

- Automatic Openstack installation
- Preeseeds and Kickstarts
- mkdocs ci for documentation
- Add git commit templates

```
git config --global commit.template ~/.git/commit-template.txt

```
- PolKit configuration
- Alternative Utilities:
    - lsusb -> cyme
    - VPN -> wireguard
- Proper configuration of libsecret / KWalletd6
- Flatpak portal configuration and app envvar for Wayland


# DEPRECATED:

- Usage of AwesomeWM: Switched to KDE

## Setting up Awesome Themes

- Install awesome WM
- Setup awesome-freedesktop
- Setup awesome-copycats
- Copy rc.lua from rc.lua.template
- Edit to enable theme
  - Set alacritty or urxvt as x-terminal
  - Set rofi at mod + x
  - Set OpenWeatherMap API city code to local city code

