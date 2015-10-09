DOWNLOAD = curl -O
DESTDIR = $(HOME)
MKDIR = mkdir -p
INSTALL = cp
FILES = .bashrc .bash_profile .gitconfig .gnus .sbclrc .screenrc .stumpwmrc .xinitrc \
	.config/compton/compton.conf .config/dunst/dunstrc .config/git/ignore \
	.config/gtk-3.0/settings.ini .config/stumpwm/contrib $(wildcard .config/stumpwm/*.lisp) \
	.config/xorg/Xmodmap .config/xorg/Xresources .config/gtkrc-2.0 .emacs.d/init.el \
	.ncmpcpp/config

all: $(addprefix $(DESTDIR)/, $(FILES))

quicklisp.lisp:
	$(DOWNLOAD) https://beta.quicklisp.org/quicklisp.lisp
$(DESTDIR)/.sbclrc: quicklisp.lisp install.lisp
	sbcl --load install.lisp
$(DESTDIR)/.config/stumpwm/contrib:
	git clone https://github.com/stumpwm/stumpwm-contrib.git $(DESTDIR)/.config/stumpwm/contrib
$(DESTDIR)/%: %
	test -z $(@D) || mkdir -p $(@D)
	$(INSTALL) $< $(@D)
