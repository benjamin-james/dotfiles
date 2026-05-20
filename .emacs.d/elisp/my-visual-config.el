
;;; line numbers
(global-display-line-numbers-mode 1)

(use-package hl-todo
  :ensure t
  :hook ((prog-mode . hl-todo-mode)
	 (markdown-mode . hl-todo-mode)
	 (text-mode . hl-todo-mode))
  :custom-face
  (hl-todo ((t (:inherit hl-todo :italic t)))))

(window-divider-mode 0)
(setq window-divider-default-places t)

;;; set active mode line to teal
(set-face-attribute 'mode-line nil
		    :weight 'medium
		    :box '(:line-width 1 :style released-button))

(set-face-attribute 'mode-line-inactive nil
		    :weight 'light
		    :box '(:line-width 1 :style released-button))

(setq-default show-trailing-whitespace t)
(set-face-foreground 'trailing-whitespace (face-attribute 'default :foreground))
(set-face-background 'trailing-whitespace (face-attribute 'secondary-selection :background))

(with-eval-after-load 'eglot
  (set-face-foreground 'eglot-mode-line (face-attribute 'mode-line :foreground))
  (set-face-background 'eglot-mode-line (face-attribute 'mode-line :background)))

(with-eval-after-load 'corfu
  (set-face-background 'corfu-default (face-attribute 'default :background))
  (set-face-foreground 'corfu-default (face-attribute 'default :foreground))
  (set-face-background 'corfu-current (face-attribute 'highlight :background))
  (set-face-foreground 'corfu-current (face-attribute 'highlight :foreground))
  (set-face-background 'corfu-border (face-attribute 'mode-line-inactive :background)))


(setq inhibit-splash-screen t)
(provide 'my-visual-config)
