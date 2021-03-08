#!/bin/bash

# help
if [ "$1" = "-h" ]; then
	echo "Hello! This script use ss command.
It can read IP adresses and names of processed
and show names of organizations from whois
You can type name of processes and number checking IP.
Example:sh whois-connect.sh opera 5"
	exit
fi

# start check
if [ -n "$1" ] && [ -n "$2" ] && [ $# -eq 2 ];
then
	echo "Great! :-) You take me two ("$#") parametres: "$1" and "$2"."
else
	echo "Sorry. :-( I need 2 parametres for working. But you insert something wrong.
Please, take me correct name of process and numbers IP in your next attempt."
exit
fi


if (echo "$1" | grep -E -q "^.{1,30}$");
then
	proc=$1
else
	proc=firefox
	echo "You not set correct name of process. I will use default name - firefox."
fi

if (echo "$2" | grep -E -q "^[0-9]{1,19}$");
then
	num_ip=$2
else
	num_ip=5
  echo "You not set correct number of IP. I will work with 0-5 IP addreses"
fi

# get data and preparing
raw_data=`ss -tunap`
filtered_data=$(echo "$raw_data" | awk '/'${proc}'/ {print $6}')
trimmed_data=$(echo "$filtered_data" | cut -d: -f1)
clean_data=$(echo "$trimmed_data" | sort | uniq -c | sort )
last_data=$(echo "$clean_data" | tail -n "$num_ip" )
echo "$last_data"

ip_table=$(echo "$last_data" | grep -oP '(\d+\.){3}\d+')
echo "$ip_table"

# whois func
for ip in $ip_table
do
whois $ip | awk -F':' '/^Organization|^Netname/ {print $2}'
done
