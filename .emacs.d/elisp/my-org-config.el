
(use-package org
  :straight nil
  :config (org-babel-do-load-languages
	   'org-babel-load-languages
	   '((python . t)
	     (R . t)
	     (julia . t)))
	   (setq org-confirm-babel-evaluate nil))
