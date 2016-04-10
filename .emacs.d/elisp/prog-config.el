;;; prog-config.el --- Summary
;;;
;;; Commentary:
;;; Programming configurations
;;;
;;; Code:

(add-hook 'prog-mode-hook
	  (lambda ()
	    (setq show-trailing-whitespace t)
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(req-package corral
  :bind (("s-(" . corral-parentheses-backward)
	 ("s-)" . corral-parentheses-forward)
	 ("s-[" . corral-brackets-backward)
	 ("s-]" . corral-brackets-forward)
	 ("s-{" . corral-braces-backward)
	 ("s-}" . corral-braces-forward)
	 ("s-\"" . corral-double-quotes-backward)
	 ("s-`" . corral-backquote-backward)
	 ("s-'" . corral-single-quotes-backward)))

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
	     (global-set-key (kbd "<f6> n") 'gud-next)
	     (global-set-key (kbd "<f6> s") 'gud-step)))
(setq gdb-many-windows t
      gdb-show-main t)
(global-set-key (kbd "<f6> g") 'gdb)

(global-set-key (kbd "<f5>")
		(lambda ()
		  (interactive)
                  (setq-local compilation-read-command nil)
                  (call-interactively 'compile)))

(provide 'prog-config)
;;; prog-config.el ends here
