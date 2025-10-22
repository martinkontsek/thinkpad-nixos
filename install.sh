#!/usr/bin/env bash
NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild boot --flake ~/zaneyos/#amd
