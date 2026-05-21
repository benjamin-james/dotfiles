
;;; config: need cyrus xoauth package 
;;;
;;;; oama authorize microsoft benjames@mit.edu --device
;;;
;;;; mbsync -a
;;;
;;;; mu init --maildir=$HOME/Mail --my-address=benjames@mit.edu --my-address=benjames@csail.mit.edu
;;;; mu index

(use-package mu4e
  :if (let ((p (locate-library "mu4e.el" nil load-path)))
	(and p (file-exists-p p)))
  :commands (mu4e)
  :ensure nil
  :straight nil
  :config
  (setq mu4e-headers-some-unread t
	shr-width 80)
  (setq mu4e-maildir "~/Mail")
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-update-interval 300)
  (setq mu4e-index-update-in-background t)

  ;; do not let mu4e permanently delete too aggressively
  ;; deletion behavior is still controlled by folder moves + mbsync expunge rules
  (setq mu4e-change-filenames-when-moving t)

  ;; msmtp
  (setq message-send-mail-function #'message-send-mail-with-sendmail)
  (setq sendmail-program "msmtp")
  (setq message-sendmail-extra-arguments '("--read-envelope-from"))
  (setq message-sendmail-f-is-evil t)

  ;; general display
  (setq mu4e-view-show-images t)
  (setq mu4e-headers-date-format "%Y-%m-%d %H:%M")
  (setq mu4e-headers-fields
	'((:human-date . 16)
	  (:flags . 6)
	  (:from-or-to . 25)
	  (:subject)))
  (setq mu4e-contexts
	`(,(make-mu4e-context
	    :name "MIT"
	    :match-func
	    (lambda (msg)
	      (when msg
		(string-prefix-p "/mit/" (mu4e-message-field msg :maildir))))
	    :vars
	    '((user-mail-address . "benjames@mit.edu")
	      (user-full-name . "Benjamin James")
	      (mu4e-sent-folder . "/mit/Sent Items")
	      (mu4e-drafts-folder . "/mit/Drafts")
	      (mu4e-trash-folder . "/mit/Deleted Items")
	      (mu4e-refile-folder . "/mit/Archive")
	      (mu4e-sent-messages-behavior . sent)
	      (smtpmail-smtp-user . "benjames")
	      (message-sendmail-extra-arguments . ("--read-envelope-from" "-a" "mit"))))
	  ,(make-mu4e-context
	    :name "CSAIL"
	    :match-func
	    (lambda (msg)
	      (when msg
		(string-prefix-p "/csail/" (mu4e-message-field msg :maildir))))
	    :vars
	    '((user-mail-address . "benjames@csail.mit.edu")
	      (user-full-name . "Benjamin James")
	      (mu4e-sent-folder . "/csail/Sent")
	      (mu4e-drafts-folder . "/csail/Drafts")
	      (mu4e-trash-folder . "/csail/Trash")
	      (mu4e-refile-folder . "/csail/Archive")
	      (mu4e-sent-messages-behavior . sent)
	      (smtpmail-smtp-user . "benjames")
	      (message-sendmail-extra-arguments . ("--read-envelope-from" "-a" "csail"))))))
  (setq mu4e-context-policy 'pick-first)
  (setq mu4e-compose-context-policy 'ask-if-none))


