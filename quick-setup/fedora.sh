#!/bin/bash

echo "CONFIGURING DNF..."
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf
echo 'defaultyes=True' | sudo tee -a /etc/dnf/dnf.conf

echo "UPDATING SYSTEM..."
sudo dnf update -y

echo "ENABLING RPM FUSION..."
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf groupupdate core -y

echo "ADDING FLATHUB REPO..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "INSTALLING MEDIA CODECS..."
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y
sudo dnf group upgrade --with-optional Multimedia -y

echo "INSTALLING EXTRA FONTS..."
sudo dnf install fira-code-fonts 'mozilla-fira*' 'google-roboto*' -y

echo "Installing Microsoft Fonts"
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

echo "Installing SF Mono Nerd Font"
curl -LO https://github.com/epk/SF-Mono-Nerd-Font/archive/refs/tags/v15.0d5e1.tar.gz
tar -xzvf v15.0d5e1.tar.gz
mv SF-Mono* ~/.local/share/fonts/
rm v15.0d5e1.tar.gz

echo "Installing Comic Mono"
curl -O https://dtinth.github.io/comic-mono-font/ComicMono.ttf
curl -O https://dtinth.github.io/comic-mono-font/ComicMono-Bold.ttf
mkdir Comic-Mono
mv ComicMono* Comic-Mono/
mv Comic-Mono/ ~/.local/share/fonts/

echo "LAST STEP"

echo "SETTING UP ADW-GTK3"
flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
sudo dnf copr enable nickavem/adw-gtk3 -y
sudo dnf install adw-gtk3 -y

echo "DONE"
