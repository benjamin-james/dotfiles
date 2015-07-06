#!/bin/sh
#Must have sbcl or clisp and llvm, clang, and cmake installed
#It wouldn't hurt to have most and ack installed too.
cp .bashrc ~
cp .emacs ~

#This installs all ELPA stuff and also installs irony server
emacs -nw --eval '(irony-server-install)'
