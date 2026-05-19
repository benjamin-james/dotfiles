(use-package ess
  :ensure t
  :init
  (setq ess-use-ido nil
	ess-use-company nil
	ess-use-compilation-script nil
	ess-use-flymake nil
	ess-use-auto-complete nil
	ess-ask-for-ess-directory nil
	ess-eval-visibly 'nowait
	ess-default-style 'DEFAULT
	ess-r-args-electric-paren nil
	ess-r-args-show-as nil
	ess-indent-level 2)
  :config
  (setq ess-r--no-company-auto t)
  (with-eval-after-load 'ess-r-mode
    (define-key ess-r-mode-map (kbd "C-c C-n")
		#'ess-eval-line-visibly-and-step)
    (define-key ess-r-mode-map (kbd "C-c C-f")
		#'ess-eval-function-or-paragraph-and-step)
    (define-key ess-r-mode-map (kbd "C-c M->")
		(lambda () (interactive)
		  (insert " |> ")))
    (define-key ess-r-mode-map (kbd "C-c M-j")
		#'ess-eval-line)
    (define-key ess-r-mode-map (kbd "C-c C-r")
		#'ess-eval-region)
    (define-key ess-r-mode-map (kbd "C-c C-d C-d")
		#'ess-display-help-on-object)))


(use-package ess-view-data
  :after ess
  :ensure t)
(use-package polymode :ensure t)
(use-package poly-R :ensure t)
(use-package poly-markdown :ensure t)

(add-to-list 'auto-mode-alist '("\\.Rmd\\'" . poly-gfm+r-mode))
(add-to-list 'auto-mode-alist '("\\.rmd\\'" . poly-gfm+r-mode))

(provide 'my-r-config)
