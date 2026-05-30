
(use-package envrc
  :ensure t
  :config
  (envrc-global-mode))

(use-package devdocs
  :ensure t
  :bind (("C-h D" . devdocs-lookup))
  :config
  (setq devdocs-browser-function 'eww))

(use-package yaml-mode)

;;; QoL
(repeat-mode 1)
(global-subword-mode)

;;; TODO fix
(use-package dtrt-indent
  :ensure t
  :init
  (dtrt-indent-global-mode 1))

;;; IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("org" (mode . org-mode))
	       ("magit" (name . "^magit"))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")))))))
(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))

;;; Dired
(setq dired-dwim-target t
      dired-recursive-copies 'always
      dired-recursive-deletes 'always
      dired-auto-revert-buffer t)

(defun eww-view-file ()
  "View the current buffer in EWW, so you can now read HTML."
  (interactive)
  (if (buffer-file-name)
      (eww (concat "file://" (buffer-file-name)))))


(provide 'my-misc-config)
