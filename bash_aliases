alias chrome='google-chrome &> /dev/null'
alias xd='xdg-open'
alias logout='gnome-session-quit'
alias naut='nautilus . & xdotool search --onlyvisible --class nautilus windowactivate'
alias foxit='FoxitReader &> /dev/null'

# protect for error of recursively removed folders
alias rm='rm -v -I'
alias evince='evince 2>/dev/null'
alias getIP='curl ipecho.net/plain;echo'
alias wifi_reset='sudo service network-manager restart'
alias os_version='cat /etc/*-release'

