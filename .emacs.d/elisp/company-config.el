;;; company-config.el --- Summary
;;;
;;; Commentary:
;;; This holds company-mode stuff
;;;
;;; Code:

(req-package company
  :bind (("C-<tab>" . company-complete-common)
	 ("C-TAB" . company-complete-common))
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(req-package company-irony
  :require company irony
  :config
  (add-to-list 'company-backends 'company-irony))

(req-package slime-company
  :require company slime
  :config
  (add-to-list 'slime-init-list 'slime-company))

(provide 'company-config)
;;; company-config.el ends here
