
;; Install and configure tree-sitter for syntax highlighting
(use-package tree-sitter
  :ensure t
  :demand t
  :config
  (global-tree-sitter-mode) 
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)


(provide 'my-tree-sitter)
