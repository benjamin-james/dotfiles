
;; Store all backup and autosave files in their own directory since it is bad to
;; clutter project directories. This also backs up TRAMP files locally.
(setq backup-directory-alist '((".*" . "~/.emacs.d/backup"))
      kept-new-versions 10
      kept-old-versions 4
      delete-old-versions t
      ;; Don't clobber symlinks.
      backup-by-copying t
      ;; Don't break multiple hardlinks.
      backup-by-copying-when-linked t
      ;; Use version numbers for backup files.
      version-control t
      ;; Backup even if file is in vc.
      vc-make-backup-files t
      auto-save-list-file-prefix "~/.emacs.d/autosave/"
      auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t))
      ;; Don't create `#file-name' lockfiles in $PWD. Lockfiles are useful but
      ;; they generate too much activity from tools watching for changes during
      ;; development.
      create-lockfiles nil
      ;; Increase undo limit to 5MB per buffer.
      undo-limit 5242880)

(provide 'my-versioning)
