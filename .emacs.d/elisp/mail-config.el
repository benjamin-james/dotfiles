;;; mail-config.el --- Summary
;;;
;;; Commentary:
;;; mail stuff
;;;
;;; Code:

(setq
 gnus-select-method '(nnmaildir "default" (directory "~/.mail/"))
 mail-sources '((maildir :path "~/.mail/" :subdirs ("cur" "new")))
 mail-source-delete-incoming t)
(setq gnus-secondary-select-methods nil)
(setq gnus-message-archive-group "nnmaildir+default:outbox")

(add-hook 'message-setup-hook 'mml-secure-message-sign-pgpmime)

;;mutt settings
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))

(defun my-mail-mode-hook ()
  "This is my hook for mail mode."
  (auto-fill-mode 1)
  (abbrev-mode 1)
  (local-set-key "\C-Xk" 'server-edit))

;; http://groups.google.com/group/gnu.emacs.gnus/browse_thread/thread/a673a74356e7141f
(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root "") ;; "● ")
  (setq gnus-sum-thread-tree-false-root "") ;; "◯ ")
  (setq gnus-sum-thread-tree-single-indent "") ;; "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))

(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))

(setq gnus-summary-display-arrow t)

(add-hook 'mail-mode-hook 'my-mail-mode-hook)

(provide 'mail-config)
;;; mail-config.el ends here
