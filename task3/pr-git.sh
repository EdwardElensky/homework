#!/bin/bash

# help ===================
if [ "$1" = "-h" ]; then
        echo "Hello! This script ver.0.1beta use github API.
It can show names contributors and number of pull-request
You should type name and repo. Example: pr-git.sh mozilla-mobile firefox-ios "
        exit
fi

# start check ============
if [ -n "$1" ] && [ -n "$2" ] && [ $# -eq 2 ];
then
        echo "Start work with two ("$#") parametres: "$1" and "$2"."
else
        echo "I need 2 parametres. Please, take me name and repo."
exit
fi

if (echo "$1" | grep -E -q "^.{1,30}$");
then
        name=$1
else
        name=mozilla-mobile
        echo "You not set correct name. I will use default name."
fi

if (echo "$2" | grep -E -q "^.{1,30}$");
then
        repo=$2
else
        repo=firefox-ios
  echo "You not set correct repo. Now will be use default repo."
fi

# construct link ==(no use)==============
# target-link=$(echo "https://api.github.com/repos/$name/$repo/pulls?q=state%3Aopen")
# short link          https://api.github.com/repos/$name/$repo/pulls?state=open
# example # https://api.github.com/repos/mozilla-mobile/firefox-ios/pulls?q=state%3Aopen


# construct link and get data ===========
if [ ! -r ./pulls.json ]; then
echo "Json file does not exist!"
while true; do
    read -p "Do you wish to download this file?(Y/N) " yn
    case $yn in
        [Yy]* ) echo "I try download..."; curl -s https://api.github.com/repos/$name/$repo/pulls?q=state%3Aopen > ./pulls.json; break;;
        [Nn]* ) echo "Hasta la vista "; exit;;
        * ) echo "Please answer (Y)yes or (N)no. ";;
    esac
done

else
# ==============================
echo "get dates from file..."
raw_tab=$(jq '.[].user.login' pulls.json)
# echo "$raw_tab"
echo "sorting data..."
sort_tab=$(echo "$raw_tab" | sort | uniq -c | sort -r)

echo "$sort_tab"

echo "Profit!"



fi
exit
