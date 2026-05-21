
(use-package exec-path-from-shell
  :when (or (memq window-system '(mac ns x))
            (daemonp))
  :init
  (message "Loading exec path from shell")
  (dolist (var '("GOPATH" "GPG_TTY" "SSH_AUTH_SOCK"
                 "MY_PKGSRC" "MY_EPREFIX" "MACPORTS_PREFIX"))
    (exec-path-from-shell-copy-env var))
  (exec-path-from-shell-initialize))


(provide '2-my-exec)

