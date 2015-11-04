;;; mail-config.el --- Summary
;;;
;;; Commentary:
;;; mail stuff
;;;
;;; Code:

(setq
 gnus-select-method '(nnmaildir "inbox" (directory "~/.mail/"))
 mail-sources '((maildir :path "~/.mail/" :subdirs ("cur" "new")))
 mail-source-delete-incoming t)
(setq gnus-secondary-select-methods nil)
(setq gnus-message-archive-group "nnmaildir+inbox:outbox")

;;mutt settings
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))

(provide 'mail-config)
;;; mail-config.el ends here
