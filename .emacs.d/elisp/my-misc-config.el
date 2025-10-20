



  ;; (use-package eglot)
  ;; :straight (eglot :type git
  ;;                  :host nil
  ;;                  :repo "git://git.sv.gnu.org/emacs.git"
  ;;                  :files ("lisp/progmodes/eglot.el")))


(use-package envrc
  :ensure t
  :config
  (envrc-global-mode))
(use-package devdocs
  :ensure t
  :bind (("C-h D" . devdocs-lookup))
  :config
  (setq devdocs-browser-function 'eww))

;(use-package poly-markdown)
;(use-package markdown-mode)

;(use-package org-journal)

;; (defun company-R-objects--prefix ()
;;   (unless (ess-inside-string-or-comment-p)
;;     (let ((start (ess-symbol-start)))
;;       (when start (buffer-substring-no-properties start (point))))))

;; (defun company-R-objects--candidates (arg)
;;   (let ((proc (ess-get-next-available-process)))
;;     (when proc (with-current-buffer (process-buffer proc)
;; 		 (all-completions arg (ess--get-cached-completions arg))))))

;; (defun company-capf-with-R-objects--check-prefix (prefix)
;;   (cl-search "$" prefix))

;; (defun company-capf-with-R-objects (command &optional arg &rest ignored)
;;   (interactive (list 'interactive))
;;   (cl-case command
;;     (interactive (company-begin-backend 'company-R-objects))
;;     (prefix (company-R-objects--prefix))
;;     (candidates (if (company-capf-with-R-objects--check-prefix arg)
;; 		    (company-R-objects--candidates arg)
;; 		  (company-capf command arg)))
;;     (annotation (if (company-capf-with-R-objects--check-prefix arg)
;; 		    "R-object"
;; 		  (company-capf command arg)))
;;     (kind (if (company-capf-with-R-objects--check-prefix arg)
;; 	      'field
;; 	    (company-capf command arg)))
;;     (doc-buffer (company-capf command arg))))

(provide 'my-misc-config)
