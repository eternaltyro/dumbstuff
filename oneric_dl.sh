#!/bin/bash

ISO_URL=http://cdimage.ubuntu.com/daily-live/current/oneric.iso
FILE_PATH=/var/clonezilla

pushd $FILE_PATH
wget --background --quiet $ISO_URL


pushd 
