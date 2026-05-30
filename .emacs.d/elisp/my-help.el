
(use-package helpful
  :ensure t
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h x" . helpful-command)))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1)
  (setq which-key-popup-type 'minibuffer
        which-key-idle-delay 1.0)) ;; long delay to not clutter

