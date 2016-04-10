;;; my-helm-config.el --- Summary
;;;
;;; Commentary:
;;; helm stuff
;;;
;;; Code:

(defvar helm-alive-p nil)
(req-package helm
  :bind (("C-c h a" . helm-apropos)
	 ("C-c h b" . helm-resume)
	 ("C-c h e" . helm-info-emacs)
	 ("C-c h f" . helm-find)
	 ("C-c h g" . helm-info-gnus)
	 ("C-c h i" . helm-info-at-point)
	 ("C-c h l" . helm-locate)
	 ("C-c h m" . helm-man-woman)
	 ("C-c h o" . helm-occur)
	 ("C-c h r" . helm-regexp)
	 ("C-c h t" . helm-top)
	 ("C-c h <tab>" . helm-lisp-completion-at-point)
	 ("C-h SPC" . helm-all-mark-rings)
	 ("C-x b" . helm-mini)
	 ("C-x C-f" . helm-find-files)
	 ("M-x" . helm-M-x)
	 :map helm-map
	 ("<tab>" . helm-execute-persistent-action)
	 ("C-i" . helm-execute-persistent-action)
	 ("C-z" . helm-select-action))
  :config
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

(req-package helm-swoop
  :require helm
  :bind (("M-i" . helm-swoop)
	 ("M-I" . helm-swoop-back-to-last-point)
	 ("C-c M-i" . helm-multi-swoop)
	 ("C-x M-i" . helm-multi-swoop-all)
	 :map isearch-mode-map
	 ("M-i" . helm-swoop-from-isearch)
	 :map helm-swoop-map
	 ("M-i" . helm-multi-swoop-all-from-helm-swoop)
	 ("M-m" . helm-multi-swoop-current-mode-from-helm-swoop)
	 ("C-r" . helm-previous-line)
	 ("C-s" . helm-next-line)
	 :map helm-multi-swoop-map
	 ("C-r" . helm-previous-line)
	 ("C-s" . helm-next-line))
  :config
  (setq helm-multi-swoop-edit-save t
	helm-swoop-split-with-multiple-windows nil
	helm-swoop-split-direction 'split-window-vertically
	helm-swoop-speed-or-color t
	helm-swoop-move-to-line-cycle t
	helm-swoop-use-line-number-face t
	helm-swoop-use-fuzzy-match t))

(provide 'helm-config)
;;; my-helm-config.el ends here
