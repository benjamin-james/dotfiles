;;; my-perl-config.el --- Summary
;;;
;;; Commentary:
;;; Perl config
;;;
;;; Code:

;;; Replace perl-mode with cperl-mode
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

(add-hook 'cperl-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-h m") 'cperl-perldoc)))
(defvar cperl-indent-level tab-width)

(provide 'my-perl-config)
;;; my-perl-config.el ends here
