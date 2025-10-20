
(use-package flymake-ruff
  :ensure t
  :hook (python-mode . flymake-ruff-load)
        (eglot-managed-mode . flymake-ruff-load))
