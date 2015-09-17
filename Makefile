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
	cp gitconfig ~/.gitconfig
	mkdir -p ~/.config/git && cp gitignore ~/.config/git/ignore
	cp -r .config ~
	cp -r .emacs.d ~
	emacs -nw --eval '(irony-server-install)'

