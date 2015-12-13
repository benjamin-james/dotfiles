#!/bin/sh
# Run this every minute with cron for fun stuff
[ $[ $RANDOM % 4 ] == 0 ] && $(DISPLAY=:0.0 /usr/bin/notify-send "Fortune" "$(fortune)")
