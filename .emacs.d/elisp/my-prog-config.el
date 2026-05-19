
(use-package apheleia
  :commands (apheleia-mode apheleia-global-mode)
  :config
  ;; prefer `goimports' instead of default `gofmt'
  (when (executable-find "goimports")
    (setf (alist-get 'go-mode apheleia-mode-alist) '(goimports)))
  (when (executable-find "ruff")
    (setf (alist-get 'python-mode apheleia-mode-alist) '(ruff)))
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
