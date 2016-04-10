;;; 0-init-utils.el --- Summary
;;;
;;; Commentary:
;;; Some necessary utils that are in other config files
;;;
;;; Code:

;; Gets the first executable
(defun get-first-existing (items)
  "This function returns the first string in ITEMS to exist within $PATH."
  (let ((output nil))
    (dolist (x items)
      (setq output (executable-find x))
      (if (not (or (eq output nil) (equal "" output)))
	  (return (remove ?\n output))))))


;;c indent style
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(defmacro bind-key-file (key file)
  "Sets a keybinding to open a file"
  (let ((filename (intern (concat "open-" file))))
    `(progn
       (defun ,filename ()
	 (interactive)
	 (find-file ,file))
       (global-set-key (kbd ,key) ',filename))))

(setq slime-init-list '())
(provide '0-init-utils)
;;; 0-init-utils.el ends here
