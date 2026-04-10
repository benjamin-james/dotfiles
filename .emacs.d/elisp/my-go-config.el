
(use-package go-mode
  :after yasnippet
  :init
  (setenv "PATH" (concat (getenv "PATH") ":" "/usr/local/go/bin"))
  (add-to-list 'exec-path "/usr/local/go/bin")

  (setenv "GOPATH" (expand-file-name "~/.local/share/go"))
  (setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/.local/share/go/bin")))
  (add-to-list 'exec-path (expand-file-name "~/.local/share/go/bin"))
  :bind
  (:map go-mode-map
        ("C-c C-e" . (lambda ()
                       (interactive)
                       (yas-expand-snippet (yas-lookup-snippet "error"))))))


