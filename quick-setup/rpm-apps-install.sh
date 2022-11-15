#!/bin/bash

echo "Installing Tweaks, Alacritty, VS Code, Steam, htop, gThumb, Solaar"
sudo dnf install -y gnome-tweaks alacritty code steam htop gthumb solaar

echo "Installing Brave Browser"
sudo dnf install dnf-plugins-core -y
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser -y

echo "Installing ProtonVPN"
sudo rpm -i https://repo.protonvpn.com/fedora-36-stable/release-packages/protonvpn-stable-release-1.0.1-1.noarch.rpm
sudo dnf update -y
sudo dnf install protonvpn -y
