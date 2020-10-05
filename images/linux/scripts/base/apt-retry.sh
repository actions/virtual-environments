#!/bin/bash -e

i=0
tput sc
while fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
    case $(($i % 4)) in
        0 ) j="-" ;;
        1 ) j="\\" ;;
        2 ) j="|" ;;
        3 ) j="/" ;;
    esac
    if [ -n "$TERM" ] && [ "$TERM" = "unknown" ] ; then
        TERM=rc
    fi
    tput rc
    echo -en "\r[$j] Waiting for other software managers to finish..." 
    sleep 0.5
    ((i=i+1))
done 

/usr/bin/apt "$@"