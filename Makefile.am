bin_SCRIPTS = $(wildcard ./bin/*.sh)

CLEANFILES =

if EMACS
emacsdir = $(dotfilesdir)/.emacs.d
dist_emacs_DATA = .emacs.d/init.el
elispdir = $(emacsdir)/elisp
dist_elisp_DATA = $(wildcard .emacs.d/elisp/*.el)
endif

if BASH
bashdir = $(dotfilesdir)
dist_bash_DATA = .bash_logout .bash_profile
CLEANFILES += .bash_profile
endif

if SYSTEMD
systemddir = $(dotfilesdir)/.config/systemd/user
dist_systemd_DATA = .config/systemd/user/jupyter_luria@.service
CLEANFILES += .config/systemd/user/jupyter_luria@.service
endif

if GIT
gitignoredir = $(dotfilesdir)/.config/git
dist_gitignore_DATA = .config/git/ignore
gitconfigdir = $(dotfilesdir)
dist_gitconfig_DATA = .gitconfig
endif

if SCREEN
screendir = $(dotfilesdir)
dist_screen_DATA = .screenrc
endif

if TMUX
tmuxdir = $(dotfilesdir)
dist_tmux_DATA = .tmux.conf
endif

if CONDA
condainitdir = $(dotfilesdir)/src
dist_condainit_DATA = src/conda_init.sh
CLEANFILES += src/conda_init.sh
endif

if SSH
sshdir = $(HOME)/.ssh
dist_ssh_DATA = .ssh/config
CLEANFILES += .ssh/config
endif
