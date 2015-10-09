(in-package :stumpwm)

(mapcar #'load-module '("battery-portable"
			"cpu"
			"disk"
			"hostname"
			"mem"
			"net"
			"wifi"))

(setf *screen-mode-line-format*
      (list
       "[^B%n^b]"
       " %B"
       ;" ^[^B^7*%h^]"
       " ^>| " ;align right
       ;"%f " ;cpu speed
       ;"%t " ;cpu temp
       ;" %M |" ;memory
       ;" %N |" ;memory
       " %d |" ;date
       " %D |" ;disk
       " %c |" ;cpu load
       " %l |" ;wireless
       ))
(setf *mode-line-timeout* 1)

;1 is red, 2 is green, 3 is yellow, 4 is blue, 5 is majenta, 6 is cyan, 7 is white, 
