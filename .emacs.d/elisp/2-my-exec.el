
(use-package exec-path-from-shell
  :when (memq window-system '(mac ns x))
  :init
  (message "Loading exec path from shell")
  (exec-path-from-shell-initialize))

(provide '2-my-exec)

