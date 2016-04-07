;;; my-helm-config.el --- Summary
;;;
;;; Commentary:
;;; helm stuff
;;;
;;; Code:

(defvar helm-alive-p nil)
(req-package helm
  :config
  (global-set-key (kbd "C-c h a") 'helm-apropos)
  (global-set-key (kbd "C-c h b") 'helm-resume)
  (global-set-key (kbd "C-c h e") 'helm-info-emacs)
  (global-set-key (kbd "C-c h f") 'helm-find)
  (global-set-key (kbd "C-c h g") 'helm-info-gnus)
  (global-set-key (kbd "C-c h i") 'helm-info-at-point)
  (global-set-key (kbd "C-c h l") 'helm-locate)
  (global-set-key (kbd "C-c h m") 'helm-man-woman)
  (global-set-key (kbd "C-c h o") 'helm-occur)
  (global-set-key (kbd "C-c h r") 'helm-regexp)
  (global-set-key (kbd "C-c h t") 'helm-top)
  (global-set-key (kbd "C-c h <tab>") 'helm-lisp-completion-at-point)
  (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
  (setq helm-split-window-in-side-p t
	helm-lisp-fuzzy-completion t
	helm-apropos-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-move-to-line-cycle-in-source t
	helm-ff-file-name-history-use-recentf t
	helm-ff-search-library-in-sexp        t
	helm-scroll-amount 8)
  (helm-autoresize-mode t)
  :init
  (helm-mode 1))

(req-package helm-projectile
  :require helm projectile
  :config
  (setq projectile-completion-system 'helm))

(provide 'helm-config)
;;; my-helm-config.el ends here
