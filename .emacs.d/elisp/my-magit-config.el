
(defun magit-spook ()
  (progn
    (goto-char (point-min))
    (insert "\n")
    (spook)
    (goto-char (point-min))))

(use-package magit
  :config (add-hook 'git-commit-setup-hook 'magit-spook)
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))

(use-package forge
  :after magit)

(provide 'my-magit-config)
