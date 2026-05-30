
(use-package go-mode
  :after yasnippet
  :bind
  (:map go-mode-map
        ("C-c C-e" . (lambda ()
                       (interactive)
                       (yas-expand-snippet (yas-lookup-snippet "error"))))))

(provide 'my-go-config)
