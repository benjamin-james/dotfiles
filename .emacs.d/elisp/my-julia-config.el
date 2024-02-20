
(use-package eat
  :ensure t)
(use-package julia-snail
  :ensure t
  :config (setq julia-snail-executable (concat (getenv "HOME") ".juliaup/bin/julia"))
  :custom
  (julia-snail-terminal-type :eat)
  :hook (julia-mode-hook . julia-snail-mode))
