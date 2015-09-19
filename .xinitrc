userresources=$XDG_CONFIG_HOME/xorg/Xresources
usermodmap=$XDG_CONFIG_HOME/xorg/Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap

# in case we have problems we can check the log
exec >> $XDG_DATA_HOME/xorg/xsession-errors 2>&1

[[ -f $sysresources ]] && xrdb -merge $sysresources
[[ -f $sysmodmap ]] && xmodmap $sysmodmap
[[ -f $userresources ]] && xrdb -merge $userresources
[[ -f $usermodmap ]] && xmodmap $usermodmap

xsetroot -solid gray35
xsetroot -cursor_name left_ptr

pulseaudio --start &

feh --bg-scale $HOME/Pictures/wallpaper.jpg
compton -b --backend glx --vsync opengl-swc
xfce4-panel &
dunst &
(sleep 2 && devmon) &
(sleep 2 && nm-applet --sm-disable) &
(sleep 2 && blueman-applet) &

#exec i3
exec sbcl --load $XDG_CONFIG_HOME/stumpwm/start-stump.lisp

