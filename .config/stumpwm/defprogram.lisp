(in-package :stumpwm)
(defmacro defprogram (name command key properties &key rat)
  "macro that sets up a program like use-package in emacs"
  (let ((name-focus (intern1 (concat (string name) "-FOCUS")))
	(name-pull (intern1 (concat "PULL-" (string name)))))
    `(progn
       (shifting-command ,name ,properties ,command ,rat)
       (define-key *top-map*
	   (kbd ,(concatenate 'string "s-" key))
	 ,(string name))
       (defcommand ,name-focus () ()
	 "run this command"
	 (run-shell-command ,command))
       (define-key *top-map*
	   (kbd ,(concatenate 'string "s-" (string-upcase key)))
	 ,(string name-focus))
       (defcommand ,name-pull () ()
	 "pull this command"
	 (run-or-pull ,command ,properties))
       (define-key *root-map*
	   (kbd ,(concatenate 'string "C-" (string-upcase key)))
	 ,(string name-pull)))))
