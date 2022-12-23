e!/bin/bash

# install stow
sudo dnf install stow -y

# stow dotfiles
stow alacritty
stow bash
stow git
stow starship
stow vim
stow nvim
