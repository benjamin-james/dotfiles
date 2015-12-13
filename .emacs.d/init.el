;;; init.el --- Summary
;;;
;;; Commentary:
;;; My init file
;;;
;;; Code:
(let ((file-name-handler-alist nil))
  (defconst emacs-start-time (current-time))
  (unless noninteractive
    (message "Loading %s..." load-file-name))
  ;;; REALLY speeds up init
  (setq-default gc-cons-threshold (* 100 1024 1024))

  (setq message-log-max 10000)

  (eval-and-compile
    (require 'package)
    (add-to-list 'load-path
		 "~/.emacs.d/elisp")
    (setq package-archives
	  '(("gnu" . "https://elpa.gnu.org/packages/")
	    ;("melpa-stable" . "https://stable.melpa.org/packages/")
	    ("melpa" . "https://melpa.org/packages/")
	    ("org" . "http://orgmode.org/elpa/")))
    (package-initialize)
    (setq package-enable-at-startup nil)
    (require 'cl)
    (require 'cl-lib)
    (unless package-archive-contents
      (package-refresh-contents))
    (unless (package-installed-p 'use-package)
      (package-install 'use-package))
    (unless (package-installed-p 'req-package)
      (package-install 'req-package))
    (require 'use-package))

  (setq use-package-always-ensure t)

  (use-package req-package)

  (dolist (file (sort (file-expand-wildcards "~/.emacs.d/elisp/*.el") #'string<))
    (message "Loading %s" file)
    (load-library (file-name-sans-extension file))
    (message "Loading %s...done (%.3fs)" file (float-time (time-subtract (current-time) emacs-start-time))))

  (req-package-finish)
  (message "Loading %s...done (%.3fs)" load-file-name (float-time (time-subtract (current-time) emacs-start-time))))
(provide 'init)
;;; init ends here
