
(use-package rustic
  :init
  (add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
  :custom
  (rustic-analyzer-command '("rustup" "run" "stable" "rust-analyzer"))
  :config
  (setq rustic-format-on-save nil) ; apheleia handles instead
  (setq rustic-lsp-client 'eglot))
