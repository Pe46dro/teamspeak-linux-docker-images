#!/bin/sh

if [ -e ts3server.pid ]; then
        if ( kill -0 $(cat ts3server.pid) 2> /dev/null ); then
                echo "Server is running"
                exit 0
        else
                echo "Server seems to have died"
                exit 1
        fi
else
        echo "No server running (ts3server.pid is missing)"
        exit 1
fi
