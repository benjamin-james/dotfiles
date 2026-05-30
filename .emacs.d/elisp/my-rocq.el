(use-package proof-general
  :straight (proof-general :type git :host github :repo "ProofGeneral/PG")
  :mode ("\\.v\\'" . coq-mode)
  :init (setq proof-prog-name "opam exec -- rocq"))
