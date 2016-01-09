#!/bin/bash
# Adapted from https://gist.github.com/alexDarcy/4352909

dis=`formail -X From: -X Subject:`

from=`echo "$dis" | formail -X From: | sed 's/From: //'`
sub=`echo "$dis" | formail -X Subject | sed 's/Subject: //'`

from=${from//</\(}
from=${from//>/\)}
from=${from//&/\.}
sub=${sub//</\(}
sub=${sub//>/\)}
sub=${sub//&/\.}

sub=${sub:0:75}
from=${from:0:75}

export XAUTHORITY=$HOME/.Xauthority
export DISPLAY=:0.0
exec /usr/bin/notify-send -u normal "New mail from $from" "$sub" -i mail-unread
