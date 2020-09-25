sudo apt-get update
sudo apt-get upgrade -y

# for editing
sudo apt-get install vim vim-gtk tmux
# for work
sudo apt-get install git tig man curl

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
# make all files non-executeable
find . -type f -exec chmod -x {} \;

cp tmux.conf ~/.tmux.conf
cp windows/wsl.bash_aliases ~/.bash_aliases
cp tigrc ~/.tigrc
cp inputrc ~/.inputrc
cp gitconfig ~/.gitconfig
cp bash_profile ~/.bash_profile
sudo cp windows/wsl.conf /etc/wsl.conf

# reboot

# download VcXsrv for copy/paste
cd ~/Downloads
wget https://downloads.sourceforge.net/project/vcxsrv/vcxsrv/1.20.8.1/vcxsrv-64.1.20.8.1.installer.exe
cmd.exe /C vcxsrv-64.1.20.8.1.installer.exe

#install gVim
wget https://ftp.nluug.nl/pub/vim/pc/gvim82.exe
cmd.exe /C gvim82.exe
