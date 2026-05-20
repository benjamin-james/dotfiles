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
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package eglot
  :commands (eglot eglot-ensure)
  :demand t
  :init
  (add-hook 'prog-mode-hook #'eglot-ensure)
  :config
  (setq eglot-stay-out-of '(company))
  (add-to-list 'eglot-ignored-server-capabilites :documentOnTypeFormattingProvider) ;; use other formatting tools instead
  (add-to-list 'eglot-server-programs '((python-mode python-ts-mode) . ("pylsp")))
  (add-to-list 'eglot-server-programs '((cperl-mode perl-mode perl-ts-mode) . ("pls")))
  (setq-default eglot-workspace-configuration
		'((:pylsp . (:plugins
			     (:pycodestyle (:enabled :json-false)
					   :mccabe (:enabled :json-false)
					   :pyflakes (:enabled :json-false)
					   :flake8 (:enabled :json-false :maxLineLength 88)
					   :ruff (:enabled t :lineLength 88)
					   :pydocstyle (:enabled t :convention "numpy")
					   :yapf (:enabled :json-false)
					   :autopep8 (:enabled :json-false)
					   :black (:enabled t :line_length 88 :cache_config t)))))))

(provide 'my-eglot)
