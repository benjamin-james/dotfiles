(require 'cl-lib)
(require 'project)
(require 'subr-x)

(defcustom my/agent-shell-root
  (expand-file-name "~/opt/agent/")
  "Host root containing per-agent workspaces."
  :type 'directory)

(defun my/agent-shell--normalize-dir (dir)
  (file-name-as-directory (expand-file-name dir)))

(defun my/agent-shell--project-root (&optional dir)
  (let* ((dir (or dir default-directory))
         (proj (project-current nil dir)))
    (cond
     (proj
      (my/agent-shell--normalize-dir (project-root proj)))
     ((locate-dominating-file dir ".git")
      (my/agent-shell--normalize-dir (locate-dominating-file dir ".git")))
     (t
      (my/agent-shell--normalize-dir dir)))))

(defun my/agent-shell--container-name-from-dir (&optional dir)
  "Infer Incus container name from DIR under ~/opt/agent/${name}/..."
  (let* ((root (file-truename (my/agent-shell--normalize-dir my/agent-shell-root)))
         (proj (file-truename (my/agent-shell--project-root dir))))
    (unless (file-in-directory-p proj root)
      (error "Project is not under %s: %s" root proj))
    (let* ((rel (file-relative-name proj root))
           (first (car (split-string rel "/" t))))
      (unless (and first (not (string-empty-p first)))
        (error "Could not infer container name from %s" proj))
      first)))

(defun my/agent-shell--container-root (&optional dir)
  "Return ~/opt/agent/${name}/ for DIR."
  (let ((name (my/agent-shell--container-name-from-dir dir)))
    (my/agent-shell--normalize-dir
     (expand-file-name name my/agent-shell-root))))

(defun my/agent-shell-incus-runner (buffer)
  "Dynamic `agent-shell-command-prefix' for BUFFER."
  (with-current-buffer buffer
    (let ((name (my/agent-shell--container-name-from-dir default-directory)))
      (list "incus" "exec" name "-T" "--" "sudo" "-iu" "agent"))))
(my/agent-shell-incus-runner (current-buffer))
(defun my/agent-shell-resolver (path)
  "Map between host paths under ~/opt/agent/${name}/ and container /data/..."
  (let* ((path (expand-file-name path))
         (container-root (file-truename (my/agent-shell--container-root)))
         (remote-root "/data/"))
    (cond
     ;; Host -> container
     ((file-in-directory-p (file-truename path) container-root)
      (concat remote-root
              (file-relative-name (file-truename path) container-root)))

     ;; Container -> host
     ((string-prefix-p remote-root path)
      (expand-file-name (string-remove-prefix remote-root path) container-root))

     ;; Exact /data
     ((string= path "/data")
      (directory-file-name container-root))

     ;; Otherwise leave unchanged.
     (t
      path))))


(use-package agent-shell
  :config
  (setq agent-shell-container-command-runner #'my/agent-shell-incus-runner)
  (setq agent-shell-path-resolver-function #'my/agent-shell-resolver)
  (setq agent-shell-goose-authentication
	(agent-shell-make-goose-authentication :none t))
  (setq agent-shell-goose-acp-command '("acp-run"))
  (setq agent-shell-openai-codex-acp-command '("acp-run")))

;  (setq agent-shell-command-prefix '("incus" "exec" "agent-c1" "-T" "--" "sudo" "-iu" "agent"))

