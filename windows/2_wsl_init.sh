sudo apt-get update
sudo apt-get upgrade -y

# for editing
sudo apt-get install vim vim-gtk tmux
# for work
sudo apt-get install git tig man

# put home folder in same as Windows folder
sudo su
cd /home
# rename username
mv luigi backup_luigi
ln -s
# link with Windows username
ln -s /mnt/c/Users/Admunger/ luigi
exit
cd ~/

mkdir ~/Backup
cd ~/Backup

git clone https://github.com/admunger/dotfiles.git
cd dotfiles

cp tmux.conf ~/.tmux.conf
cp windows/wsl.bash_aliases ~/.bash_aliases
cp tigrc ~/.tigrc
cp inputrc ~/.inputrc
cp gitconfig ~/.gitconfig
cp bash_profile ~/.bash_profile
sudo cp windows/wsl.conf /etc/wsl.conf

# reboot
