#!/bin/bash

echo "Installing Flatpak Apps"

flatpak install flathub com.mattjakeman.ExtensionManager org.mozilla.firefox com.spotify.Client org.videolan.VLC org.qbittorrent.qBittorrent com.github.iwalton3.jellyfin-media-player  -y

echo "Setting Wayland as display server for Firefox"
sudo flatpak override --env=MOZ_ENABLE_WAYLAND=1
