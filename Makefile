DOWNLOAD = curl -O

all: ql install

quicklisp.lisp:
	$(DOWNLOAD) https://beta.quicklisp.org/quicklisp.lisp

ql: quicklisp.lisp install.lisp
	sbcl --load install.lisp
install:
	cp .bashrc ~
	cp .bash_profile ~
	cp .xinitrc ~
	cp .stumpwmrc ~
	cp .gitconfig ~
	cp -r .config ~
	cp -r .emacs.d ~
	git config --global core.excludesfile '~/.config/git/ignore'
	emacs -nw --eval '(irony-server-install)'

