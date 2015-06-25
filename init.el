;;;;
;;;; Ben's emacs init file
;;;;

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
;(add-to-list 'package-archives
;	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(defconst my-packages
  '(c-eldoc
    auto-complete
    ac-c-headers
    chess
    cl-generic
    golden-ratio
    helm
    helm-mt
    helm-projectile
    magit
    markdown-mode
    monokai-theme
    multi-term
    nyan-mode
    slime
    sr-speedbar
    yasnippet
    zenburn-theme))
;;
;;Auto-installation of my-packages !!!
;;
(defun install-packages ()
  "Install the packages"
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package my-packages)
    (unless (package-installed-p package)
      (package-install package))))
(install-packages)

;;cross-platform "root directory"
(defvar emacs-root
  (eval-when-compile
    (if (or (eq system-type 'cygwin)
	    (eq system-type 'gnu/linux)
	    (eq system-type 'linux)
	    (eq system-type 'darwin))
	"~/\\.emacs\\.d/" "%HOMEPATH%/emacs\\.d/"))
  "Path to the .emacs.d directory")

(add-to-list 'load-path
	     (concat emacs-root "custom"))
(require 'cl)
(require 'cl-lib)
(require 'whitespace)
(require 'ac-c-headers)
(require 'chess)
(require 'golden-ratio)
(golden-ratio-mode 1)

;;; I really should organize this
(require 'helm)
(require 'helm-config)
(require 'helm-projectile)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c h o") 'helm-occur)
(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))
(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
	helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
(setq helm-split-window-in-side-p           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t)
(helm-autoresize-mode t)
(helm-mode 1)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;(defun pl/helm-alive-p ()
;  (if (boudp 'helm-alive-p)
;      (symbol-value 'helm-alive-p)))
;(add-to-list 'golden-ratio-inhibit-functions 'pl/helm-alive-p)
(when (display-graphic-p)
  (require 'nyan-mode)
  (nyan-mode))
(require 'sr-speedbar)
(setq speedbar-show-unknown-files t)
(require 'yasnippet)
(yas-global-mode 1)
(add-hook 'term-mode-hook (lambda()
			    (setq yas-dont-activate t)))
(require 'slime)
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))
(slime-setup '(slime-fancy slime-asdf))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
	     (concat emacs-root "ac-dict"))
(ac-config-default)
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")


(require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0")
(global-set-key (kbd "M-g s") 'magit-status)

(require 'multi-term)
(require 'helm-mt)
(global-set-key (kbd "C-x t") 'helm-mt)
(setq multi-term-program "/bin/bash")
(global-set-key (kbd "M-t") 'multi-term)
(global-set-key (kbd "M-n") 'multi-term-next)
(global-set-key (kbd "M-p") 'multi-term-prev)
(global-set-key (kbd "C-x M-t") 'multi-term-dedicated-open)
(global-set-key (kbd "C-x M-h") 'multi-term-dedicated-toggle)
(global-set-key (kbd "C-x M-s") 'multi-term-dedicated-select)
(global-set-key (kbd "C-x M-c") 'multi-term-dedicated-close)



(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;;formatting
(setq-default indent-tabs-mode t)
(setq-default tab-width 8)

(add-hook 'prog-mode-hook
	  (lambda ()
	    (interactive)
	    (setq show-trailing-whitespace t)
	    (setq nuke-trailing-whitespace t)))
;;my theme
(load-theme 'zenburn t)
(c-add-style "ben-style"
	     '("linux" (c-offsets-alist
			(arglist-cont-nonempty
			 c-lineup-gcc-asm-reg
			 c-lineup-arglist-tabs-only))))
(setq c-default-style "ben-style")

;;displays function header in minibuffer
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
(add-hook 'c-mode-hook
	  (lambda ()
	    (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))

(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'gdb)
;;
;; Variables for emacs in X
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-use-system-font t)
 '(fringe-mode 0 nil (fringe))
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 465)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
