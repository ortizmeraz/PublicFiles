sudo apt update
sudo apt upgrade -y
sudo apt install nala -y
sudo nala install qemu-guest-agent -y

sudo nala install neofetch -y
sudo nala install python3 -y
sudo nala install curl -y
sudo nala install ranger -y
sudo nala install btop -y
sudo nala install exa -y
sudo nala install tmux -y
sudo nala install fish -y
sudo nala install bat -y
sudo nala install python3-pip -y

curl -sS https://starship.rs/install.sh | sh

mkdir -p ~/.config 
mkdir -p ~/.config/tmux
mkdir -p ~/Shared

sudo chmod 777 ~/Shared -R
 
rm ~/.bashrc
curl -o ~/.bashrc https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/.bashrc

rm ~/.config/fish/config.fish
curl -o ~/.config/fish/config.fish https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/config.fish

rm ~/.config/starship.toml
curl -o ~/.config/starship.toml https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/starship.toml

# rm /etc/samba/smb.conf
# curl -o /etc/samba/smb.conf https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/smb.conf


cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

rm ~/.tmux.conf.local
curl -o ~/.tmux.conf.local https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/tmux.conf.local

sudo systemclt enable qemu-guest-agent
sudo systemclt start qemu-guest-agent

sudo apt install fonts-firacode
fc-cache -f -v


echo "[Shared]
   path = ~/Shared
   writable = yes
   guest ok = yes
   read only = no" | sudo tee -a /etc/samba/smb.conf



sudo reboot