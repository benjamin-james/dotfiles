;;; prog-config.el --- Summary
;;;
;;; Commentary:
;;; Programming configurations
;;;
;;; Code:


(setq python-indent-offset tab-width)
(add-to-list 'slime-init-list 'slime-fancy)
(add-to-list 'slime-init-list 'slime-asdf)

(req-package jedi-core)

(req-package geiser
  :interpreter "guile"
  :config
  (add-to-list 'scheme-mode-hook 'geiser-mode))

(req-package company-jedi
  :config
  (add-to-list 'company-backends '(company-jedi company-files)))

(req-package paredit
  :config
  (add-to-list 'lisp-mode-hook 'paredit-mode))

;;; Replace perl-mode with cperl-mode
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

(add-hook 'cperl-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-h m") 'cperl-perldoc)))
(defvar cperl-indent-level tab-width)

(req-package slime
  :config
					;(setq inferior-lisp-program (get-first-existing '("sbcl" "clisp")))
  (setq inferior-lisp-program "sbcl")
  (setq slime-contribs '(slime-fancy))
  :init
  (slime-setup slime-init-list))

(add-hook 'prog-mode-hook
	  (lambda ()
	    (setq show-trailing-whitespace t)
	    (setq nuke-trailing-whitespace-p t)))

(req-package magit
  :bind ("C-x g" . magit-status))

(req-package yasnippet
  :config
  (add-hook 'term-mode-hook
	    (lambda ()
	      (setq yas-dont-activate t)))
  (define-key yas-minor-mode-map (kbd "\t") 'yas-expand)
  (define-key yas-minor-mode-map (kbd "<TAB>") 'yas-expand)
  :init
  (yas-global-mode 1))

(add-hook 'gud-mode-hook
	  '(lambda ()
	     (global-set-key (kbd "<f6> n") 'gud-next)
	     (global-set-key (kbd "<f6> s") 'gud-step)))
(setq gdb-many-windows t
      gdb-show-main t)
(global-set-key (kbd "<f6> g") 'gdb)

(provide 'prog-config)
;;; prog-config.el ends here
