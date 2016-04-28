;;; my-lisp-config.el
;;;
;;; Commentary:
;;; My Lisp config settings
;;;
;;; Code:

(req-package geiser
  :config
  (add-to-list 'scheme-mode-hook 'geiser-mode))

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
