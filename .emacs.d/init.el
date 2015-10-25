;;; init.el --- Summary
;;;
;;; Commentary:
;;; My init file
;;;
;;; Code:
(let ((file-name-handler-alist nil))
  (defconst emacs-start-time (current-time))
  (unless noninteractive
    (message "Loading %s..." load-file-name))

;;; REALLY speeds up the init
  (setq-default gc-cons-threshold (* 100 1024 1024))
  (setq message-log-max 10000)

  (eval-and-compile
    (require 'package)
    (add-to-list 'package-archives
		 '("melpa" . "http://melpa.org/packages/"))
    (package-initialize)
    (require 'cl)
    (require 'cl-lib)
    ;; Make sure all packages are downloaded
    (setq use-package-always-ensure t)
    (unless package-archive-contents
      (package-refresh-contents))
    (unless (package-installed-p 'use-package)
      (package-install 'use-package))
    (require 'use-package))
  ;; Gets the first executable
  (defun get-first-existing (items)
    "returns the first string in ITEMS to exist within $PATH"
    (let ((output nil))
      (dolist (x items)
	(setq output (executable-find x))
	(if (not (or (eq output nil) (equal "" output)))
	    (return (remove ?\n output))))))

  ;; nuke-trailing-whitespace
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

  ;;c indent style
  (defun c-lineup-arglist-tabs-only (ignored)
    "Line up argument lists by tabs, not spaces"
    (let* ((anchor (c-langelem-pos c-syntactic-element))
	   (column (c-langelem-2nd-pos c-syntactic-element))
	   (offset (- (1+ column) anchor))
	   (steps (floor offset c-basic-offset)))
      (* (max steps 1)
	 c-basic-offset)))

  (defmacro bind-key-file (key file)
    "Sets a keybinding to open a file"
    (let ((filename (intern (concat "open-" file))))
      `(progn
	 (defun ,filename ()
	   (interactive)
	   (find-file ,file))
	 (global-set-key (kbd ,key) ',filename))))

  (bind-key-file "<f2> e" "~/.emacs.d/init.el")
  (bind-key-file "<f2> s" "~/.stumpwmrc")
  (bind-key-file "<f2> C-s" "~/.config/stumpwm/")
  (bind-key-file "<f2> p" "~/src/")
  (bind-key-file "<f2> x" "~/.xinitrc")

  ;; Graphics settings
  (setq inhibit-splash-screen t)
  (setq inhibit-startup-message t)

  ;; My personal settings
  (setq-default indent-tabs-mode t)
  (setq-default tab-width 8)
  (c-add-style "ben-style"
	       '("linux" (c-offsets-alist
			  (arglist-cont-noempty
			   c-lineup-gcc-asm-reg
			   c-lineup-arglist-tabs-only))))
  (setq c-default-style "ben-style")
  (linum-mode -1) ;;;because not all buffers need line numbers
  (setq linum-format " %.4d ")

  (add-hook 'prog-mode-hook
	    (lambda ()
	      (interactive)
	      (linum-mode 1)
	      (set-face-attribute 'linum nil :background (face-attribute 'fringe :background))
	      (setq show-trailing-whitespace t)
	      (setq nuke-trailing-whitespace t)))

  ;; GDB settings
  (add-hook 'gud-mode-hook
	    '(lambda ()
	       (global-set-key (kbd "<f7>") 'gud-next)
	       (global-set-key (kbd "<f8>") 'gud-step)))
  (setq gdb-many-windows t)
  (setq gdb-show-main t)
  (global-set-key (kbd "<f6>") 'gdb)

  ;;mutt settings
  (setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))
  ;; Storing all files under this directory instead of making copies inplace
  (setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
	backup-by-copying t
	version-control t
	delete-old-versions t
	kept-new-versions 20
	kept-old-versions 5)

  ;; Unicode settings
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-language-environment "UTF-8")
  (prefer-coding-system 'utf-8)

  ;; X custom settings
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(font-use-system-font t)
   '(fringe-mode 0 nil (fringe))
   '(menu-bar-mode nil)
   '(scroll-bar-mode nil)
   '(tool-bar-mode nil)
   '(tooltip-mode nil))

  (setq mode-require-final-newline t)

  (use-package bash-completion
    :config
    (bash-completion-setup))

  (use-package c-eldoc
    :config
    (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode))

  (use-package company
    :bind (("C-<tab>" . company-complete-common)
	   ("C-TAB" . company-complete-common))
    :config
    (add-hook 'after-init-hook 'global-company-mode))

  (use-package company-c-headers
    :config
    (add-to-list 'company-backends 'company-c-headers))

  (use-package company-irony
    :config
    (add-to-list 'company-backends 'company-irony))

  (use-package flycheck
    :config (add-hook 'after-init-hook #'global-flycheck-mode))

  (use-package flycheck-color-mode-line
    :config (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

  (use-package flycheck-irony
    :config (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

  (use-package helm
    :bind (("C-c h" . helm-command-prefix)
	   ("C-x C-f" . helm-find-files)
	   ("C-x m" . helm-man-woman)
	   ("M-x" . helm-M-x))
    :config
    (global-unset-key (kbd "C-x c"))
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
    (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
    (setq helm-split-window-in-side-p t
	  helm-move-to-line-cycle-in-source t
	  helm-scroll-amount 8)
    (helm-autoresize-mode t)
    (helm-mode 1))

  (use-package helm-projectile)

  (use-package hlinum
    :config (hlinum-activate))

  (use-package irony
    :init
    (defun my-irony-mode-hook ()
      (define-key irony-mode-map [remap completion-at-point]
	'irony-completion-at-point-async)
      (define-key irony-mode-map [remap complete-symbol]
	'irony-completion-at-point-async))
    :config
    (add-hook 'irony-mode-hook 'my-irony-mode-hook)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'objc-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode))

  (use-package irony-eldoc
    :config
    (add-hook 'irony-mode-hook 'irony-eldoc))

  (use-package projectile
    :config
    (setq projectile-enable-caching t)
    (setq projectile-indexing-method 'alien)
    (setq projectile-completion-system 'helm)
    (projectile-global-mode))

  (use-package projectile-speedbar)

  (use-package seethru
    :config (if (display-graphic-p)
		(seethru 90)))

  (use-package slime-company)

  (use-package slime
    :config
    (setq inferior-lisp-program (get-first-existing '("sbcl" "clisp")))
    (setq slime-contribs '(slime-fancy))
    (slime-setup '(slime-fancy slime-asdf slime-company)))

  (use-package smart-compile
    :bind ("<f5>" . smart-compile)
    :config (add-to-list 'smart-compile-alist '(c-mode . "gcc -W -Wall -Werror -O2 -g -o %n %f")))

  (use-package smart-mode-line
    :if window-system
    :init
    (setq sml/theme 'respectful)
    (add-hook 'after-init-hook 'sml/setup))

  (use-package sr-speedbar
    :bind ("C-c C-f" . sr-speedbar-toggle)
    :config (setq speedbar-show-unknown-files t))

  (use-package magit
    :bind ("C-x g" . magit-status))

  (use-package multi-term
    :bind (("M-t" . multi-term)
	   ("M-n" . multi-term-next)
	   ("M-p" . multi-term-prev)
	   ("C-x M-t" . multi-term-dedicated-open)
	   ("C-x M-h" . multi-term-dedicated-toggle)
	   ("C-x M-s" . multi-term-dedicated-select)
	   ("C-x M-c" . multi-term-dedicated-close))
    :config (setq multi-term-program "/bin/bash"))

  (use-package yasnippet
    :config
    (add-hook 'term-mode-hook (lambda()
				(setq yas-dont-activate t)))
    (define-key yas-minor-mode-map (kbd "\t") 'yas-expand)
    (yas-global-mode 1))

;  (use-package zenburn-theme
;    :if window-system
;    :config
;    (load-theme 'zenburn t))
  (if (display-graphic-p)
      (load-theme 'tango-dark t))

  (defun reload-init ()
    "reload the init file"
    (interactive)
    (load user-init-file))

  (use-package server
    :if window-system
    :init
    (add-hook 'after-init-hook 'server-start t))

  (message "Loading %s...done (%.3fs)" load-file-name (float-time (time-subtract (current-time) emacs-start-time)))

  (provide 'init)
)
;;; init.el ends here
