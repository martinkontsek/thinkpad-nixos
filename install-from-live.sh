#!/usr/bin/env bash

#mount root partition to /mnt
# mkdir -p /mnt/boot
#mount efi partition to /mnt/boot
NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-install --impure --flake https://github.com/martinkontsek/thinkpad-nixos#amd
