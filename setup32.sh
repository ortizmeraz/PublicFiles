sudo apt update
sudo apt upgrade -y

sudo apt install neofetch -y
# sudo apt install python3 -y
sudo apt install curl -y
sudo apt install ranger -y
sudo apt install btop -y
sudo apt install exa -y
sudo apt install tmux -y
sudo apt install fish -y
sudo apt install bat -y
# sudo apt install python3-pip -y

curl -sS https://starship.rs/install.sh | sh


mkdir -p ~/.config 



rm ~/.bashrc
curl -o ~/.bashrc https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/.bashrc

rm ~/.config/fish/config.fish
curl -o ~/.config/fish/config.fish https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/config.fish

rm ~/.config/starship.toml
curl -o ~/.config/starship.toml https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/starship.toml

cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

mkdir -p ~/.config/tmux

rm ~/.tmux.conf.local
curl -o ~/.tmux.conf.local https://raw.githubusercontent.com/ortizmeraz/PublicFiles/main/tmux.conf.local


sudo apt install fonts-firacode
fc-cache -f -v
