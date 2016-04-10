;;; my-lisp-config.el
;;;
;;; Commentary:
;;; My Lisp config settings
;;;
;;; Code:

(req-package geiser
  :config
  (add-to-list 'scheme-mode-hook 'geiser-mode))

(req-package paredit
  :config
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode))

(req-package slime
  :config
  (add-to-list 'slime-init-list 'slime-fancy)
  (add-to-list 'slime-init-list 'slime-asdf)
  (setq inferior-lisp-program "sbcl"
	slime-contribs '(slime-fancy))
  :init
  (slime-setup slime-init-list))

(provide 'my-lisp-config)
;;; my-lisp-config.el ends here
