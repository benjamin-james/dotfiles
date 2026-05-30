(require 'tramp)

(defun my/agent-shell--host-from-dir (&optional dir)
  "Extract hostname from DIR's TRAMP connection, or error if not remote."
  (let* ((dir (or dir default-directory))
         (vec (and (tramp-tramp-file-p dir)
                   (tramp-dissect-file-name dir))))
    (unless vec
      (error "Not a TRAMP path: %s (pure TRAMP setup requires remote default-directory)" dir))
    (tramp-file-name-host vec)))

(defun my/agent-shell--tramp-prefix (&optional dir)
  "Build Tramp prefix for DIR's SSH connection."
  (format "/ssh:%s@%s:"
          (tramp-file-name-user (tramp-dissect-file-name (or dir default-directory)))
          (my/agent-shell--host-from-dir dir)))

(defun my/agent-shell-ssh-runner (buffer)
  "Return ssh prefix for the machine backing BUFFER's directory."
  (with-current-buffer buffer
    (let* ((vec (tramp-dissect-file-name default-directory))
           (host (tramp-file-name-host vec))
           (user (tramp-file-name-user vec)))
      (list "ssh"
            "-o" "ControlMaster=auto"
            "-o" "ControlPath=/tmp/emacs-acp-%r@%h-%p"
            "-o" "ServerAliveInterval=60"
            "-o" "ServerAliveCountMax=3"
            (concat user "@" host)))))

(defun my/agent-shell-resolver (path)
  "Map between remote /data/... and Tramp paths.

Direction 1 — Agent -> Emacs (fs/read_text_file, fs/write_text_file):
  /data/foo -> /ssh:agent@myhost:/data/foo

Direction 2 — Emacs -> Agent (resource links in prompts):
  /ssh:agent@myhost:/data/foo -> /data/foo"
  (let ((tramp-prefix (my/agent-shell--tramp-prefix)))
    (if (string-prefix-p tramp-prefix path)
        (string-remove-prefix tramp-prefix path)
      (concat tramp-prefix path))))

(use-package agent-shell
  :config
  (setq agent-shell-container-command-runner #'my/agent-shell-ssh-runner)
  (setq agent-shell-path-resolver-function #'my/agent-shell-resolver)
  (setq agent-shell-goose-authentication
	(agent-shell-make-goose-authentication :none t))
  (setq agent-shell-goose-acp-command '("acp-run"))
  (setq agent-shell-openai-codex-acp-command '("acp-run")))

