#!/bin/sh

if [ -f "$HOME/.config/screen/screenrc" ]; then
	SCREENRC="$HOME/.config/screen/screenrc"
	export SCREENRC
fi
