DOWNLOAD = curl -O
DESTDIR = $(HOME)
MKDIR = mkdir -p
INSTALL = cp
FILES = .bashrc .bash_logout .bash_profile .gitconfig .muttrc .sbclrc .screenrc .stumpwmrc \
	.xinitrc .gnupg/gpg-agent.conf .gnupg/gpg.conf .config/compton/compton.conf \
	.config/dunst/dunstrc .config/git/ignore .config/mutt/colors.linux \
	.config/stumpwm/contrib $(wildcard .config/stumpwm/*.lisp) \
	.config/xorg/Xmodmap .config/xorg/Xresources .config/gtkrc-2.0 .emacs.d/init.el \
	.ncmpcpp/config bin/spooky $(wildcard .emacs.d/elisp/*.el)

all: $(addprefix $(DESTDIR)/, $(FILES))
	source $(DESTDIR)/.bash_profile #updates environment vairables without relogging in
	mkdir -p $(XDG_CONFIG_HOME)
	mkdir -p $(XDG_CACHE_HOME)
	mkdir -p $(XDG_DATA_HOME)/xorg
quicklisp.lisp:
	$(DOWNLOAD) https://beta.quicklisp.org/quicklisp.lisp
$(DESTDIR)/.sbclrc: quicklisp.lisp install.lisp
	sbcl --load install.lisp
	cp .sbclrc $(DESTDIR)
$(DESTDIR)/.config/stumpwm/contrib:
	git clone https://github.com/stumpwm/stumpwm-contrib.git $(DESTDIR)/.config/stumpwm/contrib
$(DESTDIR)/%: %
	test -z $(@D) || mkdir -p $(@D)
	$(INSTALL) $< $(@D)
