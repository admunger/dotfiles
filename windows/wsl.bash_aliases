#!/bin/bash
PROGRAM_X86='/mnt/c/Program\ Files\ \(x86\)'
PROGRAM_X64='/mnt/c/Program\ Files'


alias ls="ls --ignore=[Nn][Tt][Uu][Ss][Ee][Rr]* --color=auto"
alias gitk="${PROGRAM_X64}/Git/cmd/gitk.exe"
alias evince="${PROGRAM_X86}/Adobe/Acrobat\ Reader\ DC/Reader/AcroRd32.exe \"$1\""
alias rm="rm -v -I"

ssh_reset() {
    pkill ssh-agent
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/private_key
}
# windows-specific aliases
alias octave='/mnt/c/Octave/Octave-5.2.0/mingw64/bin/octave-cli.exe'

# grep through multiple Word files
wordgrep()
{
    if [ "$#" == "0" ]; then
        echo "USAGE: "
        echo -e "\t wordgrep pattern filename"
        echo ""
        echo "Example : wordgrep \"[Ww]ord\" file.docx"
        echo ""
        return
    fi
    # usage : wordgrep pattern filename.docx
    GREEN='\033[1;32m'
    NC='\033[0m'
    buf="document.xml"

    if [ -e $buf ]; then
        echo "$buf exists, aborting grep"
        return
    fi


    # check if we want to grep through multiple files
    pattern=$1
    shift

    while (( "$#" )); do

        file="$1"

        # skip temporary files
        if [[ ${file} == ~* ]]; then
            shift
        else
            unzip -j "$1" word/document.xml > /dev/null
            echo -e "${GREEN}$1 ${NC}:"
            grep -o "[^>]*${pattern}[^<>]*" < document.xml

            /bin/rm ./document.xml > /dev/null
        fi

        shift

    done
}
