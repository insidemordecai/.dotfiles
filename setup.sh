#!/bin/bash

# install stow
sudo dnf install stow -y

# stow dotfiles
stow alacritty
stow bash
