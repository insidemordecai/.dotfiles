#!/bin/bash

echo "Installing Tweaks, Alacritty, VS Code, Steam, htop, gThumb, Solaar"
sudo dnf install -y gnome-tweaks alacritty code steam htop gthumb solaar

echo "Installing nautilus-open-any-terminal and starship - to work with Alacritty"
sudo dnf install nautilus-python -y
pip install nautilus-open-any-terminal
nautilus -q	# kill nautilus to load new extension
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal flatpak system
sudo dnf install starship

echo "Installing Brave Browser"
sudo dnf install dnf-plugins-core -y
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser -y

echo "Installing ProtonVPN"
sudo rpm -i https://repo.protonvpn.com/fedora-36-stable/release-packages/protonvpn-stable-release-1.0.1-1.noarch.rpm
sudo dnf update -y
sudo dnf install protonvpn -y
