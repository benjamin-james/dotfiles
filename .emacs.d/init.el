
;;
;; config setup
;; magit
;; doc
;;

;;; eglot: python-lsp-server
;;; devdocs/envrc 

(dolist (file (sort (directory-files (expand-file-name "elisp" user-emacs-directory) t "\\.el$")
		    #'string<))
    (message "Loading %s" file)
    (load-library (file-name-sans-extension file))
    (message "Loading %s...done (%.3fs)" file (float-time (time-subtract (current-time) emacs-start-time))))
(message "Loading %s...done (%.3fs)" load-file-name (float-time (time-subtract (current-time) emacs-start-time)))

