#!/bin/bash
#
# Supportlogic Base Image with essential nutrients and condiments
#
# This image is to be used as base for building frontend, backend and elastic
# images. The base image contains basic security packages and essential
# configuration changes.
#
# GCP Image Project: kansas-dev-189520
# GCP Image Family: supportlogic

# Update packages
sudo /usr/bin/apt-get update && sudo /usr/bin/apt-get -y upgrade

# Install security and other packages
sudo /usr/bin/apt-get -y install \
    git \
    acl \
    auditd \
    clamdscan \
    curl \
    dnsutils \
    netcat \
    libpam-systemd \
    libsystemd-dev \
    rkhunter

# Other packages in future
# sudo /usr/bin/apt-get -y install lynis fail2ban

# Fix SSH daemon configuration
/bin/echo "Protocol 2" | sudo /usr/bin/tee -a /etc/ssh/sshd_config
/usr/bin/ssh-keyscan -t rsa github.com | \
    sudo /usr/bin/tee -a /etc/ssh/ssh_know_hosts

# Place metadata on instance
/usr/bin/date --utc | sudo /usr/bin/tee -a /opt/base_image.ctime

# Cleanup package residues
sudo /usr/bin/apt-get -y autoremove
sudo /usr/bin/apt-get clean && sudo /usr/bin/apt-get autoclean
