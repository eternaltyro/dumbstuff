#!/usr/bin/env sh

docker images prune -a
docker container prune


yay -Sc
pacman -Sc

