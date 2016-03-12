;;; c-config.el --- Summary
;;;
;;; Commentary:
;;; This holds C config stuff
;;;
;;; Code:

(req-package c-eldoc
  :config
  (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode))

(c-add-style "ben-style"
	     '("linux" (c-offsets-alist
			(arglist-cont-noempty
			 c-lineup-gcc-asm-reg
			 c-lineup-arglist-tabs-only))))

(add-hook 'c-mode-common-hook 'hs-minor-mode)

(provide 'c-config)
;;; c-config.el ends here
