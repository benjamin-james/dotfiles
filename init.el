;;;
;;; Ben's .emacs file
;;;

;;use common lisp stuff too
(require 'cl)

;;define the emacs directory (cross platform)
(defvar emacs-root
  (eval-when-compile
    (if (or (eq system-type 'cygwin)
	    (eq system-type 'gnu/linux)
	    (eq system-type 'linux)
	    (eq system-type 'darwin))
	"~/.emacs.d/" "z:/.emacs.d/"))
  "Path to the .emacs.d directory")

;;startup without the regular splashscreen and message
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;;eldoc enabled - displays function headers
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

;;melpa - package archive
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(setq url-http-attempt-keepalives nil)

;;ido
(require 'ido)
(ido-mode t)

;;custom themes (wilson and hickey are both great)
(add-to-list 'custom-theme-load-path
	     (concat emacs-root "themes"))
(load-theme 'monokai t)

;;multi-term and my key binding for it
(add-to-list 'load-path
	     (concat emacs-root "plugins/multi-term"))
(require 'multi-term)
(setq multi-term-program "/bin/bash")
(global-set-key (kbd "M-t") 'multi-term)
(global-set-key (kbd "M-n") 'multi-term-next)
(global-set-key (kbd "M-p") 'multi-term-prev)
(global-set-key (kbd "C-x M-t") 'multi-term-dedicated-open)
(global-set-key (kbd "C-x M-h") 'multi-term-dedicated-toggle)
(global-set-key (kbd "C-x M-s") 'multi-term-dedicated-select)
(global-set-key (kbd "C-x M-c") 'multi-term-dedicated-close)

;;yasnippet and autocomplete
(add-to-list 'load-path
	     (concat emacs-root "plugins/yasnippet"))
(require 'yasnippet)
(yas-global-mode 1)
(add-to-list 'load-path
	     (concat emacs-root "plugins/autocomplete"))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
	     (concat emacs-root "ac-dict"))
(ac-config-default)
;;trigger key
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")
(setq browse-url-browser-function 'w3m-browse-url)
 (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut
 (global-set-key "\C-xm" 'browse-url-at-point)

;;
;; spacing and formatting
;;
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

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name (concat emacs-root "../"))
                                       filename))
                (setq indent-tabs-mode t)
                (setq show-trailing-whitespace t)
		(setq nuke-trailing-whitespace t)
                (c-set-style "linux-tabs-only")))))



