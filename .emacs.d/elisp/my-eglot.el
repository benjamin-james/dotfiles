
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
  :demand t
  :hook ((c-mode . eglot-ensure)
	 (c++-mode . eglot-ensure)
	;(ess-r-mode . eglot-ensure)
	 (python-mode . eglot-ensure)
)
  :config (setq eglot-stay-out-of '(company))
          (add-to-list 'eglot-server-programs '((c-mode c++-mode) "clangd"))
	  (setq-default eglot-workspace-configuration
                '((:pylsp . (:configurationSources ["flake8"]
                             :plugins (
                                       :pycodestyle (:enabled :json-false)
                                       :mccabe (:enabled :json-false)
                                       :pyflakes (:enabled :json-false)
                                       :flake8 (:enabled :json-false
                                                :maxLineLength 88)
                                       :ruff (:enabled t
                                              :lineLength 88)
                                       :pydocstyle (:enabled t
                                                    :convention "numpy")
                                       :yapf (:enabled :json-false)
                                       :autopep8 (:enabled :json-false)
                                       :black (:enabled t
                                               :line_length 88
                                               :cache_config t)))))))

(provide 'my-eglot)
