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

(global-set-key (kbd "C-x v f") 'eww-view-file)

;; Destroys those pesky ^M characters
(defun dos2unix (buffer)
  "Destroy all ^M characters in a buffer"
  (interactive "*b")
  (save-excursion
    (goto-char (point-min))
    (while (search-forward (string ?\C-m) nil t)
      (replace-match (string ?\C-j) nil t))))

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

(req-package twittering-mode)

(req-package undo-tree
  :init
  (global-undo-tree-mode))

(req-package multi-term
  :bind (("M-t" . multi-term)
	 ("M-n" . multi-term-next)
	 ("M-p" . multi-term-prev)
	 ("C-x M-t" . multi-term-dedicated-open)
	 ("C-x M-h" . multi-term-dedicated-toggle)
	 ("C-x M-s" . multi-term-dedicated-select)
	 ("C-x M-c" . multi-term-dedicated-close))
  :config
  (setq multi-term-program "/bin/bash"))

;;; Set scrolling to not stop at the end of a page
;;; for viewing PDFs or other documents
(setq doc-view-continuous t)

(provide 'misc)
;;; misc.el ends here
