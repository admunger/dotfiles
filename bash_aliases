#! /bin/bash
alias chrome='google-chrome &> /dev/null'
# Terminal variables
CHEAT="$HOME/cheatSheet"
NEXUS=/run/user/*/gvfs/*/
CDROM=/run/user/*/gvfs/cdda:*/
VIMRC=~/.vim/vimrc
alias NT='vim -c "NERDTree | call NERDTreeToggleWidth()"'
RANGER_OUTPUT="$HOME/.config/ranger/rangercd"
# Command shortcuts
alias xd='xdg-open'
alias logout='gnome-session-quit'
alias naut='nautilus . & xdotool search --onlyvisible --class nautilus windowactivate'
alias tmux='tmux -3'

# Command with default parameters/behaviour
alias rm='rm -v -I'
alias printscr='gnome-screenshot -c -a'
alias ema='emacsclient -c 2> /dev/null'
alias getIP='curl ipecho.net/plain;echo'
alias matlabT='tmux new -d "/usr/local/MATLAB/R2014a/bin/matlab;exit"'
alias wifi_reset='sudo service network-manager restart'
alias xrandr_home='xrandr --output LVDS --auto --pos 0x0 --primary --output CRT1 --mode 1280x1024 --pos 1368x0'
alias os_version='cat /var/log/installer/media-info && echo'
alias swap_clean='sudo swapoff -a && sudo swapon -a'
alias check_term_lvl='ps aux | grep -E "vim|ranger|tmux"'
#alias lshead='ls -t | head'
alias lshead='ls -ltgGhp --time-style=+%d-%b-%Y | head | sed -E "s/^[d-][rwx-]+ [0-9]+ //"'

alias ranger='ranger --choosedir=$RANGER_OUTPUT && cd "$(cat $RANGER_OUTPUT)"'
alias ranger_cd='cd "$(cat $RANGER_OUTPUT)"'
alias update_upgrade="sudo apt-get update && sudo apt-get upgrade -y"
alias Date="date +%Y/%m/%d"
alias psgrep="ps aux | grep -i "
alias bluestart="sudo service bluetooth restart"
# Command redirections
alias evince='evince &>/dev/null'
# matlab stuff
alias tmatlab="matlab -nodesktop -nosplash"
alias matlab_soft="matlab -softwareopengl"

# allows to specify a pdf name and avoid polluting terminal
foxit()
{
    ~/Applications/foxitsoftware/foxitreader/FoxitReader $1 &> /dev/null
}
