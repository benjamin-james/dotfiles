(in-package :stumpwm)
;; A nifty little recursive window shifter
(defun shift-windows-forward (frames window)
  (when frames
    (let ((frame (car frames)))
      (shift-windows-forward (cdr frames)
			     (frame-window frame))
      (when window
	(pull-window window frame)))))

(defcommand rotate-windows () ()
  "Rotate windows"
  (let* ((frames (group-frames (current-group)))
	 (window (frame-window (car (last frames)))))
    (shift-windows-forward frames window)))

