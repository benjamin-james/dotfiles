
(use-package eat
  :ensure t
  :config
  (setq eat-tramp-shells '(("ssh" . "/bin/bash")))
  (eat-eshell-mode)
  (eat-eshell-visual-command-mode))


(use-package julia-snail
  :ensure t
  :init (if (file-exists-p (expand-file-name "~/.juliaup/bin/julia"))
	    (setq julia-snail-executable (expand-file-name "~/.juliaup/bin/julia")))
  :custom
  (julia-snail-terminal-type :eat)
  :hook (julia-mode-hook . julia-snail-mode))

(use-package eglot-jl
  :ensure t
  :demand t
  :config
  (eglot-jl-init))

