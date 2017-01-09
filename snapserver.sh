#!/bin/bash
dbus-daemon --system 
avahi-daemon -D

if [ "$#" -ne 1 ]; then
    echo "No arguments for snapserver given, please se github for options..."
else
	snapserver "$@"
fi

