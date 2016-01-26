userresources=$XDG_CONFIG_HOME/xorg/Xresources
usermodmap=$XDG_CONFIG_HOME/xorg/Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap
xlog=$XDG_DATA_HOME/xorg/xsession-errors.`date '+%H:%M-%D' | sed 's,/,.,g'`

[[ -f $sysresources ]] && xrdb -merge $sysresources
[[ -f $sysmodmap ]] && xmodmap $sysmodmap
[[ -f $userresources ]] && xrdb -merge $userresources
[[ -f $usermodmap ]] && xmodmap $usermodmap

# Set mouse
xsetroot -solid gray35
xsetroot -cursor_name left_ptr

# Start compositing
compton --config $XDG_CONFIG_HOME/compton/compton.conf &

# Start notification daemon
dunst &

# Load background image
[[ -f $HOME/bin/wallpaper.sh ]] && wallpaper.sh &

# Start urxvt daemon
urxvtd &

# Make some 'humans' to killall humans
humans &

# Monitor git repositories
[[ -d $XDG_DATA_HOME/gitd ]] && git-dude $XDG_DATA_HOME/gitd &

# Start mpd
mpd &

# Start mpdcron
mpdcron &

# Start devmon
(sleep 2 && devmon) &

# Start StumpWM
exec sbcl --load $XDG_CONFIG_HOME/stumpwm/start-stump.lisp >> $xlog 2>&1
