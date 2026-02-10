sudo apt update
sudo apt install nala -y
sudo nala install -y curl xz-utils
sudo nala install -y openssh-server

# Enable + start SSH service
sudo systemctl enable --now ssh

sudo nala install -y git
sudo nala install -y starship
sudo nala install -y tmux
sudo nala install -y fzf
sudo nala install -y fastfetch
sudo nala install -y dysk
sudo nala install -y superfile
sudo nala install -y lsd
sudo nala install -y btop
sudo nala install -y tree
sudo nala install -y nerd-fonts.fira-code
sudo nala install smbclient -y

# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

flatpak install flathub net.davidotek.pupgui2
flatpak install flathub com.usebottles.bottles
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.discordapp.Discord
flatpak install flathub org.onlyoffice.desktopeditors
flatpak install flathub org.ferdium.Ferdium
flatpak install flathub com.vivaldi.Vivaldi
flatpak install flathub com.brave.Browser
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub com.obsproject.Studio
flatpak install flathub com.spotify.Client
flatpak install flathub org.videolan.VLC
flatpak install flathub io.github.ungoogled_software.ungoogled_chromium
flatpak install flathub org.kde.okular
flatpak install flathub com.bitwarden.desktop
flatpak install flathub org.localsend.localsend_app
flatpak install flathub io.github.shiftey.Desktop
flatpak install flathub org.gnome.Calendar
flatpak install flathub com.vscodium.codium


# Firewall (UFW): allow SSH (port 22) and enable firewall
sudo nala install -y ufw
sudo ufw allow OpenSSH
sudo ufw enable

# Verify
sudo systemctl status ssh --no-pager
sudo ufw status verbose

curl -fsSL https://tailscale.com/install.sh | sh

curl https://raw.githubusercontent.com/ortizmeraz/PublicFiles/refs/heads/main/.zshrc

mkdir .config

curl -L https://raw.githubusercontent.com/ortizmeraz/PublicFiles/refs/heads/main/starship.toml -o ~/.config/starship.toml

sudo reboot