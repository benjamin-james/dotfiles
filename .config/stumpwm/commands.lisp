(in-package :stumpwm)

(defcommand increase-volume () ()
	    "Increase the volume"
	    (run-shell-command "amixer sset Master unmute && amixer sset PCM 5+ unmute"))

(defcommand decrease-volume () ()
	    "Decrease the volume"
	    (run-shell-command "amixer sset Master unmute && amixer sset PCM 5- unmute"))

(defcommand mute () ()
	    "Mute/unmute the volume"
	    (run-shell-command "amixer sset Master toggle"))

(defcommand increase-brightness () ()
	    "Increase the brightness"
	    (run-shell-command "xbacklight -inc 5"))

(defcommand decrease-brightness () ()
	    "Decrease the brightness"
	    (run-shell-command "xbacklight -dec 5"))

(defcommand screenshot () ()
	    "Take a screenshot"
	    (run-shell-command "scrot -e 'mv $f ~/pictures/scrot/'"))

(defcommand dmenu () ()
	    "Run dmenu, the autocompleting launcher"
	    (run-shell-command "dmenu_run -i -b -p \"run command:\""))

(defcommand suspend () ()
	    "Suspend to ram. This requires the NOPASSWD argument in /etc/sudoers for pm-suspend"
	    (run-shell-command "sudo pm-suspend"))

(defcommand logout () ()
	    "exit out of X"
	    (run-shell-command "pkill xinit"))

(defcommand next-song () ()
	    "play the next song in playlist"
	    (run-shell-command "mpc next"))

(defcommand prev-song () ()
	    "play the previous song"
	    (run-shell-command "mpc prev"))

(defcommand stop-song () ()
	    "stop the song"
	    (run-shell-command "mpc stop"))

(defcommand play-song () ()
	    "plays/pauses the song"
	    (run-shell-command "mpc toggle"))

(defcommand run-compositor () ()
	    "Run compton"
	    (run-shell-command (concatenate 'string "compton --config " (getenv "XDG_CONFIG_HOME") "/compton/compton.conf")))
