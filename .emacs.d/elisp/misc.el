;;; misc.el --- Summary
;;;
;;; Commentary:
;;; This holds random stuff
;;;
;;; Code:


(defun eww-view-file ()
  "View the current buffer in EWW, so you can now read HTML."
  (interactive)
  (if (buffer-file-name)
      (eww (concat "file://" (buffer-file-name)))))

(global-set-key (kbd "H-v f") 'eww-view-file)

;; Destroys those pesky ^M characters
(defun dos2unix (buffer)
  "Destroy all ^M characters in a buffer"
  (interactive "*b")
  (save-excursion
    (goto-char (point-min))
    (while (search-forward (string ?\C-m) nil t)
      (replace-match (string ?\C-j) nil t))))

(req-package avy
  :bind (("C-:" . avy-goto-char)
         ("C-'" . avy-goto-char-2)
         ("M-g f" . avy-goto-line)
         ("M-g w" . avy-goto-word-1)
         ("M-g e" . avy-goto-word-0)))

(req-package visual-regexp-steroids
  :bind (("C-c r" . vr/replace)
         ("C-c q" . vr/query-replace)
         ("C-c m" . vr/mc-mark)
         :map esc-map
         ("C-r" . vr/isearch-backward) ; M-C-r
         ("C-s" . vr/isearch-forward))) ; M-C-s

(req-package goto-chg
  :bind (("s-." . goto-last-change)
         ("s-," . goto-last-change-reverse)))

(req-package move-text
  :init
  (move-text-default-bindings))

(bind-key-file "<f2> e" "~/.emacs.d/init.el")
(bind-key-file "<f2> s" "~/.stumpwmrc")
(bind-key-file "<f2> C-s" "~/.config/stumpwm/")
(bind-key-file "<f2> c" "~/src/")
(bind-key-file "<f2> x" "~/.xinitrc")

(defun sudo-edit ()
  "Edit the current buffer as sudo"
  (interactive)
  (find-file (concat "/sudo::" buffer-file-name)))
(global-set-key (kbd "C-x p") 'sudo-edit)

(defun reload-init ()
  "reload the init file"
  (interactive)
  (load user-init-file))

(req-package server
  :if window-system
  :init
  (add-hook 'after-init-hook 'server-start t))

;; Storing all files under this directory instead of making copies inplace
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)

;;; Put an extra newline at the end of files
(setq mode-require-final-newline t)

(req-package bash-completion
  :init
  (bash-completion-setup))

(req-package key-chord
  :init
  (key-chord-mode 1))

(req-package undo-tree
  :init
  (global-undo-tree-mode))

(req-package multi-term
  :bind (("s-t" . multi-term)
	 ("C-x s-t" . multi-term-dedicated-toggle))
  :config
  (setq multi-term-program "/bin/bash"))

;;; Set scrolling to not stop at the end of a page
;;; for viewing PDFs or other documents
(setq doc-view-continuous t)

;(req-package fixmee
;  :config
;  (global-fixmee-mode 1))

(req-package gnuplot
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((gnuplot . t))))

(provide 'misc)
;;; misc.el ends here
