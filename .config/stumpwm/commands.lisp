(in-package :stumpwm)
(defcommand increase-volume () ()
	    "Increase the volume"
	    (run-shell-command "amixer sset PCM 5+ unmute"))

(defcommand decrease-volume () ()
	    "Decrease the volume"
	    (run-shell-command "amixer sset PCM 5- unmute"))

(defcommand mute () ()
	    "Mute the volume"
	    (run-shell-command "amixer sset PCM mute"))

(defcommand increase-brightness () ()
	    "Increase the brightness"
	    (run-shell-command "xbacklight -inc 5"))

(defcommand decrease-brightness () ()
	    "Decrease the brightness"
	    (run-shell-command "xbacklight -dec 5"))

(defcommand screenshot () ()
	    "Take a screenshot"
	    (run-shell-command "scrot -e `mv $f ~/Pictures/scrot/$f`"))
(defcommand dmenu () ()
	    "Run dmenu, the autocompleting launcher"
	    (run-shell-command "dmenu_run -i -b -p \"run command:\""))
