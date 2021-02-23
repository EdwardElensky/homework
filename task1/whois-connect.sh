#!/bin/bash

# help info
if [ "$1" = "-h" ]; then
    echo "Hello! This script use ss command.
It can read IP adresses and names of processed
and show names of organizations from whois
You can type name of process. -p
Example:sh whois-connect.sh -p firefox"
    exit 0
fi

#input parameters

