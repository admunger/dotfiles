source ~/.bashrc

# change to block cursor
echo -ne "\e[2 q"

# make default folders 0x777 readable
export LS_COLORS="ow=04;34;40"
export DISPLAY=localhost:0.0

# default file/folder creation don't have all root privileges
umask 022
