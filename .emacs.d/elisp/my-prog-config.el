

(use-package apheleia
  :demand t
  :config
  (when (executable-find "R")
    (setf (alist-get 'ess-r-mode apheleia-mode-alist) '(r-styler)))
  ;; prefer `goimports' instead of default `gofmt'
  (when (executable-find "goimports")
    (setf (alist-get 'go-mode apheleia-mode-alist) '(goimports)
	  (alist-get 'go-ts-mode apheleia-mode-alist) '(goimports)))
  (when (executable-find "ruff")
    (setf (alist-get 'python-mode apheleia-mode-alist) '(ruff)
	  (alist-get 'python-ts-mode apheleia-mode-alist) '(ruff)))
  (when (executable-find "jq")
    (setf (alist-get 'json-mode apheleia-mode-alist) '(jq))
    (setf (alist-get 'json-ts-mode apheleia-mode-alist) '(jq)))
  (when (executable-find "yq")
    (setf (alist-get 'yaml-mode apheleia-mode-alist) '(jq))
    (setf (alist-get 'yaml-ts-mode apheleia-mode-alist) '(jq)))
  (when (executable-find "rustfmt")
    (setf (alist-get 'rustic-mode apheleia-mode-alist) '(rustfmt)
	  (alist-get 'rust-ts-mode apheleia-mode-alist) '(rustfmt)))
  (when (executable-find "shfmt")
    (setf (alist-get 'bash-ts-mode apheleia-mode-alist) '(shfmt)
	  (alist-get 'sh-mode apheleia-mode-alist) '(shfmt)))
  (when (executable-find "clang-format")
    (setf (alist-get 'c-mode apheleia-mode-alist) '(clang-format)
	  (alist-get 'c++-mode apheleia-mode-alist) '(clang-format)
	  (alist-get 'c-ts-mode apheleia-mode-alist) '(clang-format)
	  (alist-get 'c++-ts-mode apheleia-mode-alist) '(clang-format)))
  (apheleia-global-mode +1))

(use-package flymake
  :ensure t
					;  :pin gnu
  :config
  (setq flymake-diagnostic-format-alist
        '((t . (origin code message)))))
