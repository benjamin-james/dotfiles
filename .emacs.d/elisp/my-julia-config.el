
(use-package eat
  :ensure t)
(use-package julia-snail
  :ensure t
  :init (setq julia-snail-executable (concat (getenv "HOME") "/.juliaup/bin/julia"))
  :custom
  (julia-snail-terminal-type :eat)
  :hook (julia-mode-hook . julia-snail-mode))
