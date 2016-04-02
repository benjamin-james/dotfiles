;;; no-training-wheels.el --- Summary
;;;
;;; Commentary:
;;; I am taking off the training wheels
;;;
;;; Code:
(defvar no-training-wheels-minor-mode-map (make-keymap)
  "This is the no-training-wheels-minor-mode keymap.")

(let ((f (lambda (m)
           `(lambda () (interactive)
              (message (concat "Bad! Use " ,m " instead."))))))
  (dolist (lst '(("<left>" . "C-b")
	       ("<right>" . "C-f")
	       ("<up>" . "C-p")
               ("<down>" . "C-n")
               ("<C-left>" . "M-b")
	       ("<C-right>" . "M-f")
	       ("<C-up>" . "M-{")
               ("<C-down>" . "M-}")
               ("<M-left>" . "M-b")
	       ("<M-right>" . "M-f")
	       ("<M-up>" . "M-{")
               ("<M-down>" . "M-}")
               ("<delete>" . "C-d")
	       ("<C-delete>" . "M-d")
               ("<M-delete>" . "M-d")
	       ("<next>" . "C-v")
	       ("<C-next>" . "M-x <")
               ("<prior>" . "M-v")
	       ("<C-prior>" . "M-x >")
               ("<home>" . "C-a")
	       ("<C-home>" . "M->")
               ("<C-home>" . "M-<")
	       ("<end>" . "C-e")
	       ("<C-end>" . "M->")))
    (define-key no-training-wheels-minor-mode-map
      (read-kbd-macro (car lst)) (funcall f (cdr lst)))))

(define-minor-mode no-training-wheels-minor-mode
  "Minor mode that takes off the training wheels by removing arrow keys,
   delete, PgDown, PgUp, home, end, etc.

Use 'M-x no-training-wheels' to toggle this minor mode in all buffers except
the minibuffer."

nil nil 'no-training-wheels-minor-mode-map)

(defun no-training-wheels-hook ()
  "This is a hook to enable the minor mode."
  (interactive)
  (unless (minibufferp)
    (no-training-wheels-minor-mode 1)))

(define-globalized-minor-mode no-training-wheels
  no-training-wheels-minor-mode no-training-wheels-hook)

(no-training-wheels 1)

(provide 'no-training-wheels.el)
;;; no-training-wheels.el ends here
