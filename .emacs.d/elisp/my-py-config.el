

;;;
;;; Current setup: Use python-lsp-ruff plugin to manage flymake.

(defun my/flymake-ruff-setup ()
  (when (derived-mode-p 'python-mode 'python-ts-mode)
    (flymake-ruff-load)
    (flymake-start)))

;; (use-package flymake-ruff
;;   :ensure t
;;   :hook (eglot-managed-mode . my/flymake-ruff-setup))
