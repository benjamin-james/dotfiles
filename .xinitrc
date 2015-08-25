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
feh --bg-scale /home/ben/Pictures/wallpaper.jpg
exec i3
#exec stumpwm

