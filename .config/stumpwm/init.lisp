(in-package :stumpwm)

(defun load-file (file)
  (load (concatenate 'string (stumpwm::getenv "XDG_CONFIG_HOME") "/stumpwm/" file ".lisp")))

(define-key *root-map* (kbd "C-e") "emacs")
(defcommand firefox() ()
	"Start firefox"
	(run-or-raise "firefox"
		      '(:title "firefox-primary")))
(define-key *root-map* (kbd "C-f") "firefox")
(defcommand urxvt() ()
	    "Start uxrvt"
	    (run-or-raise "urxvt"
			  '(:title "urxvt-primary")))
(define-key *root-map* (kbd "C-c") "urxvt")
(load "/home/ben/.emacs.d/elpa/slime-20150830.1446/swank-loader.lisp")
(swank-loader:init)
(defcommand swank () ()
	    (swank:create-server :port 4005
				 :style swank:*communication-style*
				 :dont-close t)
	    (echo-string (current-screen)
			 "Starting swank. M-x slime-connect RET RET, then (in-package stumpwm)."))
(define-key *root-map* (kbd "C-s") "swank")
(stumpwm:toggle-mode-line (stumpwm:current-screen)
			  (stumpwm:current-head))
(mode-line)
(swank)
