#!/bin/bash

# 1. Maybe, user will wants help info.
if [ "$1" = "-h" ]; then
	echo "Hello! This script use ss command.
It can read IP adresses and names of processed
and show names of organizations from whois
You can type name of processes and number checking IP.
Example:sh whois-connect.sh opera 5"
	exit 0
fi

# 2. Checking start parameter (maybe tripple-check is too much, enought only $# -eq 2)
if [ -n "$1" ] && [ -n "$2" ] && [ $# -eq 2 ];
then
	echo "OK! I get from You two ("$#") parametres: "$1" and "$2"."
else
	echo "I need 2 parametres for working. But you insert something wrong :-("
exit
fi

# 3. Name length of process (1-30 any symbols)
if (echo "$1" | grep -E -q "^.{1,30}$");
then
	proc=$1
else
# If name more 30 symbols we will set default process
	proc=firefox
	echo "You not set correct name of process. I will use default name - firefox."
fi

# 4. Number of checked ip (any positive number)
if (echo "$2" | grep -E -q "^\+?[1-9][0-9]*$");
then
	num_ip=$2
else
# Set default number of ip if user forgoted which type numbers
	 num_ip=5
  echo "You not set correct number of IP. I will work with 0-5 IP addreses"
fi

# 5. Get raw data fromm ss output and filtered by process (changed netstat to ss and -l not used)
raw_data=`ss -tunap`
#echo "step 1. Debug raw data"
#echo "$raw_data"

# 6. Data filtered by process (I use echo because awk <<< $S not work)
filtered_data=$(echo "$raw_data" | awk '/'${proc}'/ {print $6}')
#echo "step 2. Debug filtered data"
#echo "$filtered_data"

# 7. Make trimmed data from filtered data (I can use "awk -F":" '{print $1}'" too)
trimmed_data=$(echo "$filtered_data" | cut -d: -f1)
#echo "step 3. Debug trimmed data"
#echo "$trimmed_data"

# 8. Dublicate remover (It is no bigdata ->  I used "uniq -u" instead of "sort | uniq -c")
clean_data=$(echo "$trimmed_data" | uniq -u )
#echo "step 4. Debug clean data"
#echo "$clean_data"

# 9. Now we sort our data and take last n (five) IP
last_data=$(echo "$clean_data" | tail -n "$num_ip" )
#echo "step 5.Debug last data :-)"
#echo "$last_data"

# 10. Just for fun some filter (\d+\.){3}\d+  was changed to long filter from stackowerflow %-)
ip_table=$(echo "$last_data" | grep -E "((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])")
# other regex "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
#echo "step 6. Get only ip for ip_table"
#echo "$ip_table"

# 11. Unfortunately, now I was start writed the main function of this script!
for ip in $ip_table
do
whois $ip | awk -F':' '/^[Oo]rganization|^[Nn]etname/ {print $2}'
#whois $ip | awk -F':' '/^Organization/ {print $2}'
#whois $ip | awk -F':' '/^OrgName/ {print $2}'

done
