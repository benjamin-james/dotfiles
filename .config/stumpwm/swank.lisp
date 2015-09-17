(require :swank)
(swank-loader:init)
(swank:create-server :port 4004
		     :style swank:*communication-style*
		     :dont-close t)
(defcommand swank (&optional port) ()
  (setf stumpwm:*top-level-error-action* :break)
  (swank:create-server :port (or port 4004)
		       :coding-system "utf-8"
		       :style swank:*communication-style*
		       :dont-close t)
  (message "Starting swank"))
(define-key *root-map* (kbd "C-s") "swank")
