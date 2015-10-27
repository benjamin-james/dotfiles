userresources=$XDG_CONFIG_HOME/xorg/Xresources
usermodmap=$XDG_CONFIG_HOME/xorg/Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap
wallpaper=$HOME/pictures/wallpaper.jpg
xlog=$XDG_DATA_HOME/xorg/xsession-errors

[[ -f $sysresources ]] && xrdb -merge $sysresources
[[ -f $sysmodmap ]] && xmodmap $sysmodmap
[[ -f $userresources ]] && xrdb -merge $userresources
[[ -f $usermodmap ]] && xmodmap $usermodmap

# Set mouse
xsetroot -solid gray35
xsetroot -cursor_name left_ptr

# Load background image
[[ -f $wallpaper ]] && feh --bg-scale $wallpaper

# Start compositing
compton --config $XDG_CONFIG_HOME/compton/compton.conf &

# Start notification daemon
dunst &

# Start urxvt daemon
urxvtd &

# Make some 'humans' to killall humans
humans &

# Start devmon
(sleep 2 && devmon) &

# Start NetworkManager applet
(sleep 2 && nm-applet --sm-disable) &

# Start blueman applet
(sleep 2 && blueman-applet) &

# Start StumpWM
exec sbcl --load $XDG_CONFIG_HOME/stumpwm/start-stump.lisp >> $xlog 2>&1

