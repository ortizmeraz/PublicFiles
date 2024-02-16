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
 
rm /home/omar/.bashrc
curl -o /home/omar/.config/fish/config.fish https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/.bashrc

rm /home/omar/.config/fish/config.fish
curl -o /home/omar/.config/fish/config.fish https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/config.fish

rm /home/omar/.config/starship.toml
curl -o /home/omar/.config/starship.toml https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/starship.toml

rm /etc/samba/smb.conf
curl -o /home/omar/.config/starship.toml https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/smb.conf


cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

rm ~/.tmux.conf.local
curl -o ~/.tmux.conf.local https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/tmux.conf.local

sudo systemclt enable qemu-guest-agent
sudo systemclt start qemu-guest-agent


sudo reboot