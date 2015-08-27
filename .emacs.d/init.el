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
    powerline
    projectile
    projectile-speedbar
    seethru
    slime
    slime-company
    smart-compile
    smart-tabs-mode
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

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)

(require 'cl)
(require 'cl-lib)
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent, 100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
(defun get-first-existing (items)
  "Returns the first string in ITEMS to exist within $PATH"
  (let ((output nil))
    (dolist (x items)
      (setq output (executable-find x))
      (if (not (or (eq nil output) (equal "" output)))
	  (return (remove ?\n output))))))

(setq mode-require-final-newline t)

;;Unicode
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(setq-default indent-tabs-mode t)

(setq nuke-trailing-whitespace-p t)
(defun nuke-trailing-whitespace ()
  "Nuke all trailing whitespace in the buffer.
Whitespace in this case is just spaces or tabs.
This is a useful function to put on write-file-hooks.
If the variable `nuke-trailing-whitespace-p` is `nil`, this function is
disabled.  If `t`, unreservedly strip trailing whitespace.
If not `nil` and not `t`, query for each instance."
  (interactive)
  (and nuke-trailing-whitespace-p
       (save-match-data
	 (save-excursion
	   (save-restriction
	     (widen)
	     (goto-char (point-min))
	     (cond ((eq nuke-trailing-whitespace-p t)
		    (while (re-search-forward "[        ]+$" (point-max) t)
		      (delete-region (match-beginning 0) (match-end 0))))
		   (t
		    (query-replace-regexp "[    ]+$" "")))))))
  ;; always return nil, in case this is on write-file-hooks.
  nil)
(defun how-many-region (begin end regexp &optional interactive)
  "Print number of non-trivial matches for REGEXP in region.
Non-interactive arguments are Begin End Regexp"
  (interactive "r\nsHow many matches for (regexp): \np")
  (let ((count 0) opoint)
    (save-excursion
      (setq end (or end (point-max)))
      (goto-char (or begin (point)))
      (while (and (< (setq opoint (point)) end)
		  (re-search-forward regexp end t))
	(if (= opoint (point))
	    (forward-char 1)
	  (setq count (1+ count))))
      (if interactive (message "%d occurrences" count))
      count)))

(defun infer-indentation-style ()
  ;; if our source file uses tabs, we use tabs, if spaces spaces, and if
  ;; neither, we use the current indent-tabs-mode
  (let ((space-count (how-many-region (point-min) (point-max) "^  "))
	(tab-count (how-many-region (point-min) (point-max) "^\t")))
    (if (> space-count tab-count) (setq indent-tabs-mode nil))
    (if (> tab-count space-count) (setq indent-tabs-mode t))))

;;c indent style
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	  (column (c-langelem-2nd-pos c-syntactic-element))
	   (offset (- (1+ column) anchor))
	    (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

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
;(require 'helm-projectile)
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
;(helm-projectile-on)
;(setq projectile-indexing-method 'alien)

;(require 'helm-company)
;(eval-after-load 'company
;  '(progn
;     (define-key company-mode-map (kbd "C-:") 'helm-company)
;     (define-key company-active-map (kbd "C-:") 'helm-company)))
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
(setq inferior-lisp-program (get-first-existing '("sbcl" "clisp")))
(setq slime-contribs '(slime-fancy))
(slime-setup '(slime-fancy slime-asdf slime-company))

(require 'magit)
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

(require 'powerline)
;(powerline-center-theme)
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
(require 'seethru)
(seethru 55)

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

;; Variables for emacs in X
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("54e916f82010313f8dad24e2b6641f67063d0adcb7d8f7e3b4627025504e1a56" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "108b3724e0d684027c713703f663358779cc6544075bc8fd16ae71470497304f" "a444b2e10bedc64e4c7f312a737271f9a2f2542c67caa13b04d525196562bf38" "2e5705ad7ee6cfd6ab5ce81e711c526ac22abed90b852ffaf0b316aa7864b11f" "e8a9dfa28c7c3ae126152210e3ccc3707eedae55bdc4b6d3e1bb3a85dfb4e670" "c006bc787154c31d5c75e93a54657b4421e0b1a62516644bd25d954239bc9933" "1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "de8fa309eed1effea412533ca5d68ed33770bdf570dcaa458ec21eab219821fd" "95a6ac1b01dcaed4175946b581461e16e1b909d354ada79770c0821e491067c6" default)))
 '(ecb-compile-window-height 0.25)
 '(ecb-compile-window-temporally-enlarge (quote after-selection))
 '(ecb-compile-window-width (quote edit-window))
 '(fci-rule-color "#383838")
 '(font-use-system-font t)
 '(fringe-mode 0 nil (fringe))
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 465)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

(if (display-graphic-p)
    (custom-set-faces
     ;; custom-set-faces was added by Custom.
     ;; If you edit it by hand, you could mess it up, so be careful.
     ;; Your init file should contain only one such instance.
     ;; If there is more than one, they won't work right.
     '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))))

(defun reload-init ()
  "reload the init.el file"
  (interactive)
  (load user-init-file))

					;
