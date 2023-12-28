
(use-package corfu
  :demand t
  :custom (corfu-cycle t) (corfu-auto t)
  :bind (:map corfu-map
              ("C-<tab>" . corfu-next)
              ("<tab>" . nil))  ; Unbind the default tab if desired
  :init (global-corfu-mode))

(setq tab-always-indent 'complete)
(use-package orderless
  :demand t
  :config
  (setq completion-styles '(orderless partial-completion)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package eglot
  :commands (eglot eglot-ensure)
  :hook ((c-mode . eglot-ensure)
	 (c++-mode . eglot-ensure)
	 (python-mode . eglot-ensure)
	 (R-mode . eglot-ensure))
  :config (setq eglot-stay-out-of '(company))
          (add-to-list 'eglot-server-programs '((c-mode c++-mode) "clangd-10")))

(provide 'my-eglot)
