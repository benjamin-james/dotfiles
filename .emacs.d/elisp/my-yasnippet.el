(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1) ; Enable yasnippet in all buffers
  :config
  (add-to-list 'yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory))
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)
