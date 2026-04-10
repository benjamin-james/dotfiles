
(use-package eat
  :ensure t)
(use-package julia-snail
  :ensure t
  :init (if (file-exists-p (expand-file-name "~/.juliaup/bin/julia"))
	    (setq julia-snail-executable (expand-file-name "~/.juliaup/bin/julia")))
  :custom
  (julia-snail-terminal-type :eat)
  :hook (julia-mode-hook . julia-snail-mode))

(use-package eglot-jl
  :ensure t
  :config
  (eglot-jl-init))

