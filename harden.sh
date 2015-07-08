#!/bin/bash

/usr/bin/chattr +i /bin/*
/usr/bin/chattr +i /sbin/*
/usr/bin/chattr +i /usr/bin/*
/usr/bin/chattr +i /usr/sbin/*

modprobe -r uvcvideo

