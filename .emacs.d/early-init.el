;;; early-init.el --- Emacs early init -*- lexical-binding: t; -*-

(defconst emacs-start-time (current-time))

;; [debugging]
;; (setq init-file-debug t)
;; (setq messages-buffer-max-lines 100000)

;; If an `.el' file is newer than its corresponding `.elc', load the `.el'.
(setq load-prefer-newer t)

;; Set GC to 1GiB
(setq gc-cons-threshold 1073741824
      gc-cons-percentage 0.6)

;; custom files to temp file
(setq custom-file (make-temp-file "custom-" nil ".el"))

;; Faster to disable these here (before they've been initialized)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Default frame settings. This is actually maximized, not full screen.
(push '(fullscreen . maximized) initial-frame-alist)
(push '(ns-transparent-titlebar . t) default-frame-alist)
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)
(advice-add #'x-apply-session-resources :override #'ignore)

(defvar file-name-handler-alist-old file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist file-name-handler-alist-old)))

;; Disable `package' in favor of `straight.el'.
(setq package-enable-at-startup nil)

(provide 'early-init)

;;; early-init.el ends here
