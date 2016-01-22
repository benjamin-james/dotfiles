#!/bin/bash
# Script to set wallpaper randomly
# protip: use with cron

WALLPAPERDIR=${WALLPAPERDIR:-$HOME/pictures/wallpapers}
files=($WALLPAPERDIR/*)
newpic=`printf "%s\n" "${files[RANDOM % ${#files[@]}]}"`
feh --bg-scale "$newpic"
