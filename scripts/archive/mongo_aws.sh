#!/bin/bash

yum -y update
echo -e "[MongoDB]\nname=MongoDB Repository\nbaseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64\ngpgcheck=0\nenabled=1" | sudo tee -a /etc/yum.repos.d/mongodb.repo

yum install -y mongo-10gen-server

mkdir /data 
mkdir /data/db 
mkdir /data/log

mkfs.ext4 /dev/xvdb
echo '/dev/xvdb /data ext4 defaults,auto,noatime,noexec 0 0' | sudo tee -a /etc/fstab

mount /data
chown mongod:mongod /data /data/db /data/log

chkconfig mongod on

echo -e "* soft nofile 64000\n* hard nofile 64000\n* soft nproc 32000\n* hard nproc 32000" | sudo tee -a /etc/security/limits.conf

echo -e "* soft nproc 32000\n* hard nproc 32000\nroot soft nproc unlimited" | sudo tee /etc/security/limits.d/90-nproc.conf

sudo blockdev --setra 32 /dev/xvdb

echo 'ACTION=="add", KERNEL=="xvdb", ATTR{bdi/read_ahead_kb}="16"' | sudo tee -a /etc/udev/rules.d/85-ebs.rules
