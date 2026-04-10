(use-package neocaml
  :straight (neocaml :type git :host github :repo "bbatsov/neocaml")
  :ensure t
  :mode ("\\.ml\\'"  . neocaml-mode)
  :mode ("\\.mli\\'" . neocaml-interface-mode))

(use-package ocaml-eglot
  :after neocaml
  :ensure t
  :hook
  (neocaml-base-mode . ocaml-eglot-mode)
  (ocaml-eglot-mode . eglot-ensure)
  :config
  (setq ocaml-eglot-syntax-checker 'flymake))

(use-package opam-switch-mode
  :after neocaml
  :ensure t
  :hook
  (neocaml-base-mode . opam-switch-mode))
