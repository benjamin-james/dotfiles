;;; visuals.el --- Summary
;;;
;;; Commentary:
;;; Stuff that makes emacs look good
;;;
;;; Code:

(setq emacs-opacity 90)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(linum-mode -1) ;;No linum for global usage
(setq linum-format " %.4d ")

(add-hook 'prog-mode-hook
	  (lambda ()
	    (interactive)
	    (linum-mode 1)
	    (set-face-attribute 'linum nil :background (face-attribute 'fringe :background))))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(req-package ace-window
  :bind (("M-p" . ace-window))
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?i ?j ?k ?l)))

(req-package hlinum
  :config (hlinum-activate))

(req-package org-bullets
  :init
  (defvar org-bullets-bullet-list
	'("◉" "◎" "⚫" "○" "►" "◇"))
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(req-package smart-mode-line
  :if window-system
  :config
  (setq sml/theme 'respectful)
  (add-hook 'after-init-hook 'sml/setup))

(req-package sr-speedbar
  :bind (("C-c C-f" . sr-speedbar-toggle))
  :config
  (setq speedbar-show-unknown-files t))

(req-package seethru
  :init
  (if (display-graphic-p)
      (seethru emacs-opacity)))

(if (display-graphic-p)
    (load-theme 'tango-dark t))

(provide 'visuals)
;;; visuals.el ends here
