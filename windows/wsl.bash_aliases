#!/bin/bash
PROGRAM_X86='/mnt/c/Program\ Files\ \(x86\)'
PROGRAM_X64='/mnt/c/Program\ Files'


alias ls="ls --ignore=[Nn][Tt][Uu][Ss][Ee][Rr]* --color=auto"
alias gitk="${PROGRAM_X64}/Git/cmd/gitk.exe"
alias evince="${PROGRAM_X86}/Adobe/Acrobat\ Reader\ DC/Reader/AcroRd32.exe \"$1\""
