DOWNLOAD = curl -O
DESTDIR = $(HOME)
MKDIR = mkdir -p
INSTALL = cp

EMACS_FILES = $(wildcard .emacs.d/elisp/*.el) .emacs.d/init.el
BIN_FILES = $(wildcard bin/*)
BASH_FILES = .bashrc .bash_profile .bash_logout
GIT_FILES = .gitconfig .config/git/ignore
SHELL_FILES = $(BIN_FILES) $(BASH_FILES) .screenrc $(GIT_FILES)
STUMPWM_FILES = .stumpwmrc $(DESTDIR)/.sbclrc $(wildcard .config/stumpwm/*.lisp) $(DESTDIR)/.config/stumpwm/contrib

FILES = .bashrc .bash_logout .bash_profile .gitconfig .muttrc .sbclrc .screenrc \
	.xinitrc .gnupg/gpg-agent.conf .gnupg/gpg.conf .config/compton/compton.conf \
	.config/mpd/mpd.conf .config/dunst/dunstrc .config/git/ignore .config/mutt/colors.linux \
	.config/stumpwm/contrib .procmailrc .guile $(STUMPWM_FILES) $(wildcard bin/*) \
	.config/xorg/Xmodmap .config/xorg/Xresources .config/gtkrc-2.0 $(EMACS_FILES) \
	.config/mpdcron/mpdcron.conf $(wildcard .config/mpdcron/hooks/*) .config/mpdnotify.conf \
	.config/ncmpcpp/config .config/htop/htoprc

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

shell: $(addprefix $(DESTDIR)/, $(SHELL_FILES))

bash: $(addprefix $(DESTDIR)/, $(BASH_FILES))

git: $(addprefix $(DESTDIR)/, $(GIT_FILES))

bin: $(addprefix $(DESTDIR)/, $(BIN_FILES))

emacs:
	mkdir -p $(DESTDIR)/.emacs.d/elisp
	$(shell test -f $(DESTDIR)/.emacs && mv $(DESTDIR)/.emacs $(DESTDIR)/.emacs.copy)
	$(shell test -f $(DESTDIR)/.emacs.d/init.el && mv $(DESTDIR)/.emacs.d/init.el $(DESTDIR)/.emacs.d/init.el.copy)
	$(MAKE) emacs-full

emacs-full: $(addprefix $(DESTDIR)/, $(EMACS_FILES))
	$(INSTALL) $< $(@D)

stumpwm: $(addprefix $(DESTDIR)/, $(STUMPWM_FILES))
	mkdir -p $(@D)
	$(INSTALL) $< $(@D)

.PHONY: all emacs stumpwm emacs-full
