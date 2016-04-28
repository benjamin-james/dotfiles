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

(req-package flycheck-color-mode-line
  :require flycheck
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))


(req-package flycheck-irony
  :require flycheck irony
  :config (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(defun my-flycheck-rtags-setup ()
  "sets up rtags"
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil
	      flycheck-check-syntax-automatically nil))
(req-package flycheck-rtags
  :require flycheck rtags
  :config (add-hook c-mode-common-hook #'my-flycheck-rtags-setup))

(req-package helm-flycheck
  :require helm flycheck
  :bind :map flycheck-mode-map ("C-c ! h" . helm-flycheck))
(provide 'flycheck-config)
;;; flycheck-config.el ends here
