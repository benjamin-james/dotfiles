;;; iron-config.el --- Summary
;;;
;;; Commentary:
;;; This holds irony-mode config files
;;;
;;; Code:

(req-package irony
  :init
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  :config
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode))

(req-package company-irony-c-headers
  :require company
  :config
  (add-to-list 'company-backends '(company-irony-c-headers company-irony)))

(req-package irony-eldoc
  :require irony
  :config
  (add-hook 'irony-mode-hook 'irony-eldoc))

(provide 'irony-config)
;;; irony-config.el ends here
