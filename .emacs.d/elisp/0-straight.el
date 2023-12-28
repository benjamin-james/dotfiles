
(custom-set-variables
; '(straight-repository-branch "develop")
 '(straight-check-for-modifications '(check-on-save find-when-checking))
 '(straight-use-package-by-default t)
 '(straight-vc-git-default-clone-depth 1))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(custom-set-variables
 '(use-package-always-defer t)
 '(use-package-enable-imenu-support t)
 '(use-package-hook-name-suffix nil))

(straight-use-package 'use-package)
(require 'use-package)

(provide '0-straight.el)
