
;; Install and configure tree-sitter for syntax highlighting
(use-package tree-sitter
  :ensure t
  :config
  (use-package tree-sitter-langs
    :ensure t)
  (global-tree-sitter-mode) 
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(provide 'my-tree-sitter)
