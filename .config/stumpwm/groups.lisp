(in-package :stumpwm)

(setf (group-name (current-group)) "1")
(gnewbg "2")
(gnewbg-float "3")
(gnewbg "4")

(defcommand gmove-and-follow (to-group) ((:group "To Group: "))
  "Move the current window to the specified group and go to that group"
  (when (and to-group
	     (current-window))
    (move-window-to-group (current-window) to-group)
    (switch-to-group to-group)))

(dotimes (i 6)
  (define-key *top-map*
      (kbd
       (concatenate 'string "s-"
		    (write-to-string
		     (+ 1 i))))
    (concatenate 'string "gselect " (write-to-string (+ 1 i))))
  (define-key *top-map*
      (kbd
       (concatenate 'string "M-s-" (write-to-string (+ 1 i))))
    (concatenate 'string "gmove-and-follow " (write-to-string (+ 1 i)))))
