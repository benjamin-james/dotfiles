;; Remote agent support via agent-shell-command-prefix (direct SSH).
;;
;; acp.el's `acp--start-client' calls `make-process' with
;; `:file-handler (file-remote-p default-directory)'.  When
;; default-directory is a TRAMP path, TRAMP starts the process on the
;; remote through its own SSH connection, but TRAMP injects shell
;; setup noise (locale warnings, login banner, internal protocol
;; markers like ///hash#$) into the process stream, corrupting the
;; JSON-RPC that acp.el parses.  agent-shell-tramp relies on this
;; mechanism and therefore does not work for ACP.
;;
;; Instead, `agent-shell-command-prefix' prepends an explicit SSH
;; command so make-process starts a clean local SSH subprocess that
;; runs only `acp-run' on the remote: no TRAMP shell setup, no
;; protocol markers.  `:around' advice on `acp--start-client' forces
;; `default-directory' to ~ (a valid local dir) and makes
;; `file-remote-p' return nil so `:file-handler' is nil, preventing
;; TRAMP from intercepting the process.
;;
;; `agent-shell-path-resolver-function' translates paths bidirectionally:
;; the agent speaks in remote-local paths; Emacs needs TRAMP paths.
;;
;; IMPORTANT: agent-shell depends on transient 0.13+ (for
;; `transient--set-layout').  Emacs 30 ships with a built-in transient
;; 0.7.x that lacks this function.  `straight-use-package' handles
;; putting straight's transient (and all its deps: compat, cond-let,
;; llama, seq) on load-path in the right order.  But if the built-in
;; transient was already required by something earlier, we must unload
;; it first so `require' re-loads straight's version.

(when (featurep 'transient)
  (unload-feature 'transient t))
(straight-use-package 'transient)
(require 'transient)

(defun my/agent-shell-ssh-prefix (buffer)
  "Return SSH command list to the host backing BUFFER's TRAMP path.
Returns nil for local buffers (no prefix needed).

Uses the simplest possible SSH invocation."
  (with-current-buffer buffer
    (when (tramp-tramp-file-p default-directory)
      (let* ((vec (tramp-dissect-file-name default-directory))
             (host (tramp-file-name-host vec))
             (user (tramp-file-name-user vec)))
        (list "ssh"
              (if (and user (not (string-empty-p user)))
                  (concat user "@" host)
                host))))))

(defun my/agent-shell-resolve-path (path)
  "Translate PATH between TRAMP and remote-local forms.

When default-directory is remote:
- TRAMP paths (from agent) -> remote-local paths (for Emacs file handlers)
- Remote-local paths (from agent) -> TRAMP paths (for Emacs file handlers)

When local, return PATH unchanged."
  (if (tramp-tramp-file-p default-directory)
      (let ((vec (tramp-dissect-file-name default-directory)))
        (if (tramp-tramp-file-p path)
            (tramp-file-name-localname (tramp-dissect-file-name path))
          (tramp-make-tramp-file-name vec path)))
    path))

(defun my/agent-shell-transcript-file-path ()
  "Return a LOCAL transcript path, even for remote sessions.

The default writes to (agent-shell-cwd)/.agent-shell/transcripts/,
which is a TRAMP path for remote sessions; every write triggers a
slow remote file copy.  Force transcripts under ~/.agent-shell/ so
they stay local."
  (let* ((dir (expand-file-name "~/.agent-shell/transcripts"))
         (filename (format-time-string "%F-%H-%M-%S.md")))
    (make-directory dir t)
    (expand-file-name filename dir)))

(defun my/acp-start-client-locally (orig-fn &rest args)
  "Advice around `acp--start-client' to force local process startup.

Binds `default-directory' to ~ so `file-remote-p' returns nil
naturally (make-process would fail on a TRAMP path as a local dir).
Uses `cl-letf' on `file-remote-p' as belt-and-suspenders in case
buffer switching inside acp--start-client changes default-directory."
  (let ((default-directory (expand-file-name "~")))
    (cl-letf (((symbol-function 'file-remote-p) #'ignore))
      (apply orig-fn args))))

(use-package agent-shell
  :straight t
  :demand t
  :config
  (setq agent-shell-command-prefix #'my/agent-shell-ssh-prefix)
  (setq agent-shell-path-resolver-function #'my/agent-shell-resolve-path)
  (setq agent-shell-transcript-file-path-function #'my/agent-shell-transcript-file-path)
  (setq agent-shell-session-strategy 'prompt)
  (setq agent-shell-show-session-id t)
  (setq agent-shell-goose-acp-command '("/usr/local/bin/acp-run"))
  (setq agent-shell-openai-codex-acp-command '("/usr/local/bin/acp-run"))
  (setq agent-shell-opencode-acp-command '("/usr/local/bin/acp-run"))
  (setq agent-shell-pi-acp-command '("/usr/local/bin/acp-run"))
  (advice-add 'acp--start-client :around #'my/acp-start-client-locally))
