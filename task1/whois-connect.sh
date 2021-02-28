#!/bin/bash

# help
if [ "$1" = "-h" ]; then
	echo "Hello! This script use ss command.
It can read IP adresses and names of processed
and show names of organizations from whois
You can type name of processes and number checking IP.
Example:sh whois-connect.sh opera 5"
	exit 0
fi

# start check
if [ -n "$1" ] && [ -n "$2" ] && [ $# -eq 2 ];
then
	echo "OK! I get from You two ("$#") parametres: "$1" and "$2"."
else
	echo "I need 2 parametres for working. But you insert something wrong :-("
exit
fi


if (echo "$1" | grep -E -q "^.{1,30}$");
then
	proc=$1
else
	proc=firefox
	echo "You not set correct name of process. I will use default name - firefox."
fi


if (echo "$2" | grep -E -q "^\+?[1-9][0-9]*$");
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
clean_data=$(echo "$trimmed_data" | uniq -u )
last_data=$(echo "$clean_data" | tail -n "$num_ip" )
ip_table=$(echo "$last_data" | grep -E "((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])")

# whois func
for ip in $ip_table
do
whois $ip | awk -F':' '/^Organization|^Netname/ {print $2}'
done
