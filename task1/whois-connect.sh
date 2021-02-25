#!/bin/bash

# help info
if [ "$1" = "-h" ]; then
    echo "Hello! This script use ss command.
It can read IP adresses and names of processed
and show names of organizations from whois
You can type name and number of processes.
Example:sh whois-connect.sh opera 5"
    exit 0
fi

# checking start parameter
if [ $# -eq 2 ]
then

# name of process
 proc=$1
# number of proc
 num_proc=$2

else
# set default process
proc=firefox
echo "You not set name of process. I will use default name - firefox."
fi



# get raw data fromm ss output and filtered by process (changed netstat to ss and -l not used)
raw_data=`ss -tunap`
#echo "step 1. raw data"
#echo "$raw_data"

# data filtered by process (I use echo because awk <<< $S not work)
filtered_data=$(echo "$raw_data" | awk '/'${proc}'/ {print $6}')
#echo "step 2. filtered data"
#echo "$filtered_data"

# make trimmed data from filtered data (I can use "awk -F":" '{print $1}'" too)
trimmed_data=$(echo "$filtered_data" | cut -d: -f1)
echo "step 3. trimmed data"
echo "$trimmed_data"

# dublicate remover (It is no bigdata ->  I used "uniq -u" instead of "sort | uniq -c")
clean_data=$(echo "$trimmed_data" | uniq -u )
echo "step 4. clean data"
echo "$clean_data"

# Now we sort our data and take last n (five) IP
last_data=$(echo "$clean_data" | tail -n "$num_proc" )
echo "step 5. last data :-)"
echo "$last_data"

