(setq mode-require-final-newline t)

;;Unicode
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(setq-default indent-tabs-mode t)

(setq nuke-trailing-whitespace-p t)
(defun nuke-trailing-whitespace ()
  "Nuke all trailing whitespace in the buffer.
Whitespace in this case is just spaces or tabs.
This is a useful function to put on write-file-hooks.
If the variable `nuke-trailing-whitespace-p` is `nil`, this function is
disabled.  If `t`, unreservedly strip trailing whitespace.
If not `nil` and not `t`, query for each instance."
  (interactive)
  (and nuke-trailing-whitespace-p
       (save-match-data
	 (save-excursion
	   (save-restriction
	     (widen)
	     (goto-char (point-min))
	     (cond ((eq nuke-trailing-whitespace-p t)
		    (while (re-search-forward "[        ]+$" (point-max) t)
		      (delete-region (match-beginning 0) (match-end 0))))
		   (t
		    (query-replace-regexp "[    ]+$" "")))))))
  ;; always return nil, in case this is on write-file-hooks.
  nil)
(defun how-many-region (begin end regexp &optional interactive)
  "Print number of non-trivial matches for REGEXP in region.
Non-interactive arguments are Begin End Regexp"
  (interactive "r\nsHow many matches for (regexp): \np")
  (let ((count 0) opoint)
    (save-excursion
      (setq end (or end (point-max)))
      (goto-char (or begin (point)))
      (while (and (< (setq opoint (point)) end)
		  (re-search-forward regexp end t))
	(if (= opoint (point))
	    (forward-char 1)
	  (setq count (1+ count))))
      (if interactive (message "%d occurrences" count))
      count)))

(defun infer-indentation-style ()
  ;; if our source file uses tabs, we use tabs, if spaces spaces, and if
  ;; neither, we use the current indent-tabs-mode
  (let ((space-count (how-many-region (point-min) (point-max) "^  "))
	(tab-count (how-many-region (point-min) (point-max) "^\t")))
    (if (> space-count tab-count) (setq indent-tabs-mode nil))
    (if (> tab-count space-count) (setq indent-tabs-mode t))))

;;c indent style
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	  (column (c-langelem-2nd-pos c-syntactic-element))
	   (offset (- (1+ column) anchor))
	    (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))
