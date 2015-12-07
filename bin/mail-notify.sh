#!/bin/bash
# Adapted from https://gist.github.com/alexDarcy/4352909
dis=`formail -X From: -X Subject:`
from=`echo "$dis" | formail -X From:`
sub=`echo "$dis" | formail -X Subject:`

from=${from//</\(}
from=${from//>/\)}
from=${from//&/\.}
sub=${sub//</\(}
sub=${sub//>/\)}
sub=${sub//&/\.}

sub=${sub:0:75}
from=${from:0:75}
TM=2000
$(DISPLAY=:0.0 /usr/bin/notify-send -u normal -t $TM "$sub" "$from" >> /dev/stderr)
