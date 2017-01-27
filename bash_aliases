#! /bin/bash
alias chrome='google-chrome &> /dev/null'
alias xd='xdg-open'
alias logout='gnome-session-quit'
alias naut='nautilus . & xdotool search --onlyvisible --class nautilus windowactivate'
alias foxit='FoxitReader &> /dev/null'

# protect for error of recursively removed folders
alias rm='rm -v -I'
alias evince='evince 2>/dev/null'
alias getIP='curl ipecho.net/plain;echo'
alias matlabT='tmux new -d "/usr/local/MATLAB/R2014a/bin/matlab;exit"'
alias wifi_reset='sudo service network-manager restart'
alias xrandr_home='xrandr --output LVDS --auto --pos 0x0 --primary --output CRT1 --mode 1280x1024 --pos 1368x0'
alias os_version='cat /var/log/installer/media-info && echo'
# alias ema='emacsclient --alternate-editor="" -c'
alias swap_clean='sudo swapoff -a && sudo swapon -a'
alias check_term_lvl='ps aux | grep -E "vim|ranger|tmux"'
alias lshead='ls -t | head'
alias ranger="ranger --choosedir=$HOME/.config/ranger/rangercd; cd \"$(cat $HOME/.config/ranger/rangercd)\""

CAR=/home/anubis/Documents/esteban8
LEDGERFILE=/home/anubis/Documents/ADRIEL/Argent/ledgerJournal.dat
NEXUS=/run/user/*/gvfs/*/
