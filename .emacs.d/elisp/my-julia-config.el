
(use-package eat
  :ensure t)
(use-package julia-snail
  :ensure t
  :custom
  (julia-snail-terminal-type :eat)
  :hook (julia-mode . snail-mode))
