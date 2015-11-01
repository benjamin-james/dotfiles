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
	    (run-shell-command "mpc next && notify-send \"Now Playing\" \"$(mpc current)\""))

(defcommand prev-song () ()
	    "play the previous song"
	    (run-shell-command "mpc prev && notify-send \"Now Playing\" \"$(mpc current)\""))

(defcommand stop-song () ()
	    "stop the song"
	    (run-shell-command "mpc stop"))

(defcommand play-song () ()
	    "plays/pauses the song"
	    (run-shell-command "mpc toggle && if [[ $(mpc | grep playing) ]]; then notify-send \"Now Playing\" \"$(mpc current)\"; fi"))
