#!/bin/sh
#Must have sbcl or clisp and llvm, clang, and cmake installed
#It wouldn't hurt to have most and ack installed too.
cp bashrc ~/.bashrc
cp Xresources ~/.Xresources
mkdir -p ~/.emacs.d && cp init.el ~/.emacs.d

if [[ $(which systemctl 2>/dev/null) ]]; then
    mkdir -p ~/.config/systemd/user/ && cp emacsd.service ~/.config/systemd/user/
fi
./makeissue
sudo mv issue /etc/issue
sudo chmod +x /etc/issue
sudo cp bashrc /root/bashrc
mkdir -p ~/.config/git && cp gitignore ~/.config/git/ignore
cp gitconfig ~/.gitconfig

#Borrowed from https://github.com/altercation/es-bootstraps
install_aur () {
PKG=$1
[ -d ${HOME}/tmp ] || mkdir $HOME/tmp
cd $HOME/tmp
rm -rf ${PKG}*
curl -O https://aur.archlinux.org/packages/${PKG:0:2}/${PKG}/${PKG}.tar.gz
tar -xzvf ${PKG}.tar.gz
cd ${PKG}
makepkg --noconfirm --syncdeps --clean --needed --install
cd $HOME/tmp
rm -rf ${PKG}*
}

#installs necessary packages
if [[ $(cat /etc/*-release | grep "Arch Linux") ]]; then
    sudo pacman -Syu
    which cower || install_aur cower
    which pacaur || install_aur pacaur
    which fortune || pacaur --noconfirm --noedit -S fortune-mod fortune-mod-futurama fortune-mod-montypython fortune-mod-calvin fortune-mod-matrix
    which cowsay || pacaur --noconfirm --noedit -S cowsay
    sed -i 'ls,^,[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources,' ~/.xinitrc
    xrdb -merge ~/.Xresources
    systemctl --user enable emacsd.service
    systemctl --user start emacsd.service
fi
#This installs all ELPA stuff and also installs irony server
emacs -nw --eval '(irony-server-install)'
