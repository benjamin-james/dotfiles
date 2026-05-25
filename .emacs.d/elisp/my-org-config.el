
(use-package org
  :straight nil
  :config (org-babel-do-load-languages
	   'org-babel-load-languages
	   '((python . t)
	     (perl . t)
	     (awk . t)
	     (sed . t)
	     (R . t)
	     (julia . t)
	     (octave . t)
	     (C . t)
	     (java . t)
	     (ocaml . t)
	     (haskell . t)
	     (latex . t)
	     (shell . t)
	     (eshell . t)
	     (calc . t)
	     (sql . t)
	     (lisp . t)
	     (scheme . t)
	     (clojure . t)
	     (emacs-lisp . t)))
  (setq org-confirm-babel-evaluate nil)
  (require 'ox-publish))


(use-package org-srs
  :ensure t
  :hook (org-mode . org-srs-embed-overlay-mode)
  :bind (:map org-mode-map
	      ("<f5>" . org-srs-review-rate-easy)
	      ("<f6>" . org-srs-review-rate-good)
	      ("<f7>" . org-srs-review-rate-hard)
	      ("<f8>" . org-srs-review-rate-again)))
