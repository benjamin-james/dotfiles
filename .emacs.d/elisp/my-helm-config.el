;;; helm-config.el --- Summary
;;;
;;; Commentary:
;;; helm stuff
;;;
;;; Code:

(defvar helm-alive-p nil)
(req-package helm
  :config
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x m") 'helm-man-woman)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
  (setq helm-split-window-in-side-p t
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
;;; helm-config.el ends here
