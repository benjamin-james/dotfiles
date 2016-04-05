;;; company-config.el --- Summary
;;;
;;; Commentary:
;;; This holds company-mode stuff
;;;
;;; Code:

(req-package go-mode
  :config
  (add-hook 'go-mode-hook (lambda ()
			    (local-set-key (kbd "M-.") 'godef-jump)
			    (add-hook 'before-save-hook 'gofmt-before-save))))
(req-package go-projectile
  :require projectile go-mode go-eldoc)

(req-package company-go
  :require company go-mode
  :config
  (add-hook 'go-mode-hook (lambda ()
			    (set (make-local-variable 'company-backends) '(company-go))
			    (company-mode))))
(req-package go-snippets
  :require yasnippet)

(req-package helm-go-package
  :required helm go-mode
  :config
  (substitute-key-definition 'go-import-add 'helm-go-package go-mode-map))

(req-package go-eldoc
  :require go-mode
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

;;; go-config.el ends here
