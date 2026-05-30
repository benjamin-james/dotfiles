
(defun my/path-join (&rest paths)
  "Join multiple path components into a single path, avoiding leading dots, using seq-reduce."
  (when paths
    (seq-reduce (lambda (a b)
                  (if (string-empty-p a)
                      b
                    (concat (file-name-as-directory a) b)))
                (cdr paths) (car paths))))


