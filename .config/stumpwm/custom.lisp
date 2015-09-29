(in-package :stumpwm)
;; custom functions
(defun str (&rest strings)
  (apply #'concatenate 'string strings))

(defun global (key value)
  (define-key *top-map* (kbd key) value))

