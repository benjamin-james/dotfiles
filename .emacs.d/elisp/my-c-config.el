
(use-package clang-format
  :ensure t
  :custom
  (clang-format-style "file")
  (clang-format-executable "/usr/bin/clang-format")
  :config
  (add-hook 'c++-mode-hook
	    (lambda ()
	      (add-hook 'before-save-hook #'clang-format-buffer nil t))))

(define-key c++-mode-map (kbd "C-c C-f") #'clang-format-buffer)
  
(setq c-basic-offset 8)
