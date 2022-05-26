#!/bin/sh

# NOTE: SNAPD is everywhere!! I can't throw it out T-T

# Install my favorite programs (from progs.tsv)
sudo apt install -y $(sed 's/\t.*$//g' progs.tsv)

# ------------------------------------------------------------------------------

# Install some extra stuffs...

# Discord
wget 'https://discord.com/api/download?platform=linux&format=deb' -O /tmp/discord.deb
sudo apt install -y /tmp/discord.deb

# Brave browser
sudo apt install -y apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# Visual Studio Code
sudo apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code

# Mono project
sudo apt install -y gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb [arch=amd64] https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
sudo apt install -y mono-devel

# Unity Hub
mkdir -p ~/.local/bin
wget 'https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage' -O ~/.local/bin/unityhub
chmod +x ~/.local/bin/unityhub

# ------------------------------------------------------------------------------

# Install some advanced (or just weird) tool...

# Patched libxft (get colored emojis in Suckless tools)
git clone https://github.com/uditkarode/libxft-bgra
cd libxft-bgra
sh autogen.sh --sysconfdir=/etc --prefix=/usr --mandir=/usr/share/man
sudo make install

# No login manger needed, I believe in TTY supremacy
sudo systemctl set-default multi-user

# TODO get DWM, DMENU, ST
# TODO load my dotfiles

