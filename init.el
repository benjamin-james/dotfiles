;;;;
;;;; Ben's emacs init file
;;;;

;;;TODO: break up into different .el files
;;; i.e. my-style.el, custom-functions.el, my-helm.el
;;; and use "use-package"
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
;;(add-to-list 'package-archives
;; 	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
(defconst my-packages
  '(aggressive-indent
    arduino-mode
    bash-completion
    c-eldoc
    chess
    company
    company-c-headers
    company-irony
    cl-generic
    ecb
    flycheck
    flycheck-color-mode-line
    flycheck-irony
    golden-ratio
    helm
    helm-company
    helm-mt
    helm-projectile
    irony
    irony-eldoc
    magit
    markdown-mode
    monokai-theme
    multi-term
    nyan-mode
    projectile
    projectile-speedbar
    slime
    slime-company
    smart-compile
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

(require 'aggressive-indent)
(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
(require 'bash-completion)
(bash-completion-setup)
(require 'chess)
(require 'ecb)
(global-set-key (kbd "C-c C-e") 'ecb-minor-mode)
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(require 'flycheck-color-mode-line)
(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
(require 'flycheck-irony)
(eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
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
(when (executable-find "/usr/bin/vendor_perl/ack")
  (setq helm-grep-default-command "/usr/bin/vendor_perl/ack -Hn --no-group --no-color %e %p %f"
	helm-grep-default-recurse-command "/usr/bin/vendor_perl/ack -H --no-group --no-color %e %p %f"))

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
(setq helm-split-window-in-side-p           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t)
(helm-autoresize-mode t)
(helm-mode 1)

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-indexing-method 'alien)

(require 'helm-company)
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))
;(defun pl/helm-alive-p ()
;  (if (boudp 'helm-alive-p)
;      (symbol-value 'helm-alive-p)))
;(add-to-list 'golden-ratio-inhibit-functions 'pl/helm-alive-p)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-<tab>") 'company-complete-common)
(global-set-key (kbd "C-TAB") 'company-complete-common)

(require 'company-c-headers)
(add-to-list 'company-backends 'company-c-headers)
;(require 'color)
;(let ((bg (face-attribute 'default :background)))
;  (custom-set-faces
;   `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
;   `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;   `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;   `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;   `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))
;;;;May have to M-x irony-install-server

(require 'irony-eldoc)
(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion at point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-eldoc)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(require 'company-irony)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(require 'nyan-mode)
(nyan-mode)
(nyan-start-animation)

(require 'smart-compile)
(add-to-list 'smart-compile-alist '(c-mode . "gcc -W -Wall -Werror -g -o %n %f"))
(require 'sr-speedbar)
(setq speedbar-show-unknown-files t)
(global-set-key (kbd "C-c C-f") 'sr-speedbar-toggle)
(require 'yasnippet)
(yas-global-mode 1)
(add-hook 'term-mode-hook (lambda()
			    (setq yas-dont-activate t)))
(require 'slime-company)
(require 'slime)
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))
(slime-setup '(slime-fancy slime-asdf slime-company))

(require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0")
(global-set-key (kbd "M-g s") 'magit-status)
(global-set-key (kbd "M-g m") 'magit-commit)
(global-set-key (kbd "M-g u") 'magit-push)
(global-set-key (kbd "M-g l") 'magit-pull)
(global-set-key (kbd "M-g f") 'magit-fetch)
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

(require 'projectile-speedbar)

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
(load-theme 'monokai t)

;;my-style
(c-add-style "ben-style"
	     '("linux" (c-offsets-alist
			(arglist-cont-nonempty
			 c-lineup-gcc-asm-reg
			 c-lineup-arglist-tabs-only))))
(setq c-default-style "ben-style")

;;displays function header in minibuffer
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
(add-hook 'gud-mode-hook
	  '(lambda()
	     (global-set-key (kbd "<f7>") 'gud-next)
	     (global-set-key (kbd "<f8>") 'gud-step)))
(setq gdb-many-windows t)
(setq gdb-show-main t)
(global-set-key (kbd "<f5>") 'smart-compile)
(global-set-key (kbd "<f6>") 'gdb)

;;
;; Variables for emacs in X
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-compile-window-height 0.25)
 '(ecb-compile-window-temporally-enlarge (quote after-selection))
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-layout-name "ben-layout")

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
