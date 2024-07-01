#!/usr/bin/env sh

docker images prune -a
docker container prune


yay -Rsnc $(yay -Qtdq)
yay -Sc
pacman -Sc

