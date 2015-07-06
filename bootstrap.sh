#!/bin/sh
#Must have sbcl or clisp and llvm, clang, and cmake installed
#It wouldn't hurt to have most and ack installed too.
cp bashrc ~/.bashrc
cp emacs ~/.emacs

if [[ $(which systemctl 2>/dev/null) ]]; then
    mkdir -p ~/.config/systemd/user/ && cp emacsd.service ~/.config/systemd/user/
fi
mkdir -p ~/.config/git && cp gitignore ~/.config/git/ignore
cp gitconfig ~/.gitconfig
#This installs all ELPA stuff and also installs irony server
emacs -nw --eval '(irony-server-install)'
