
(defun my/on-guix-p ()
  (file-exists-p (my/path-join (getenv "HOME") ".guix-profile")))

(use-package geiser
  :init
  (setf geiser-active-implementations '(guile)
	geiser-guile-binary "/usr/bin/guile"))

