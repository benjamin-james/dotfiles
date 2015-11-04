;;; flycheck-config.el --- Summary
;;;
;;; Commentary:
;;; Flycheck config stuff
;;;
;;; Code:

(req-package flycheck
	     :init
	     (add-hook 'c-mode-hook
			 (lambda ()
			   (setq flycheck-gcc-warngings '("all" "extra"))
			   (setq flycheck-gcc-language-standard "gnu11")))
	     :config
	     (add-hook 'after-init-hook #'global-flycheck-mode))

(req-package flycheck-color-mode-line-cookie
	     :require flycheck
	     :config
	     (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(req-package flycheck-irony
	     :require flycheck irony
	     :config (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(provide 'flycheck-config)
;;; flycheck-config.el ends here
