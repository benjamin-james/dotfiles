DOWNLOAD = curl -O
CP = cp
MKDIR_P = mkdir -p

FILES = .bashrc .bash_profile .gitconfig .gnus .sbclrc .screenrc .stumpwmrc .xinitrc \
	.config/compton/compton.conf .config/dunst/dunstrc .config/git/ignore \
	.config/gtk-3.0/settings.ini $(wildcard .config/stumpwm/*.lisp) .config/xorg/Xmodmap \
	.config/xorg/Xresources .config/gtkrc-2.0 .emacs.d/init.el .ncmpcpp/config

all: $(addprefix $(HOME)/, $(FILES))

quicklisp.lisp:
	$(DOWNLOAD) https://beta.quicklisp.org/quicklisp.lisp

$(HOME)/.sbclrc: quicklisp.lisp install.lisp
	sbcl --load install.lisp

$(HOME)/%: %
	$(MKDIR_P) $(basename $@)
	$(CP) $< $@
