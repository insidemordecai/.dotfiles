#!/bin/bash

echo "Installing Tweaks, Alacritty, Steam, htop, gThumb, Solaar"
sudo dnf install -y gnome-tweaks alacritty steam htop gthumb solaar

echo "Installing VS Code"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update -y
sudo dnf install code -y

echo "Installing nautilus-open-any-terminal and starship - to work with Alacritty"
sudo dnf install nautilus-python -y
sudo dnf install pip -y
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

echo "Installing XDM"
curl -LO https://github.com/subhra74/xdm/releases/download/7.2.11/xdm-setup-7.2.11.tar.xz
mkdir xdm-setup-dir
tar -xf xdm-setup*tar.xz -C xdm-setup-dir/
sudo ./xdm-setup-dir/install.sh
rm xdm-setup* -rf

echo "Installing ProtonVPN"
sudo rpm -i https://repo.protonvpn.com/fedora-36-stable/release-packages/protonvpn-stable-release-1.0.1-1.noarch.rpm
sudo dnf update -y
sudo dnf install protonvpn -y
