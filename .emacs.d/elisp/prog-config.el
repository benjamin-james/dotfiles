;;; prog-config.el --- Summary
;;;
;;; Commentary:
;;; Programming configurations
;;;
;;; Code:


(setq python-indent-offset 8)
(add-to-list 'slime-init-list 'slime-fancy)
(add-to-list 'slime-init-list 'slime-asdf)

(req-package jedi-core)

(req-package company-jedi
  :config
  (add-to-list 'company-backends '(company-jedi company-files)))

;;; Replace perl-mode with cperl-mode
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

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

(req-package smart-compile
	     :bind ("<f5>" . smart-compile)
	     :config
	     (add-to-list 'smart-compile-alist '(c-mode . "gcc -Wall -Wextra -O2 -ggdb -o %n %f")))

(req-package magit
	     :bind ("C-x g" . magit-status))

(req-package yasnippet
	     :config
	     (add-hook 'term-mode-hook
		       (lambda ()
			 (setq yas-dont-activate t)))
	     (define-key yas-minor-mode-map (kbd "\t") 'yas-expand)
	     ;(define-key yas-minor-mode-map (kbd "<TAB>") 'yas-expand)
	     :init
	     (yas-global-mode 1))

(add-hook 'gud-mode-hook
	  '(lambda ()
	     (global-set-key (kbd "<f7>") 'gud-next)
	     (global-set-key (kbd "<f8>") 'gud-step)))
(setq gdb-many-windows t)
(setq gdb-show-main t)
(global-set-key (kbd "<f6>") 'gdb)

(provide 'prog-config)
;;; prog-config.el ends here
