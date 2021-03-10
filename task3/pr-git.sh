#!/bin/bash

# help ===================
if [ "$1" = "-h" ]; then
        echo "Hello! This script ver.0.1beta use github API.
It can show names contributors and number of pull-request
You should type Github URL with username and repository.
Example: pr-git.sh https://github.com/mozilla-mobile/firefox-ios/ "
        exit 0
fi

# start check ============
if [ -n "$1" ] && [ $# -eq 1 ];
then
        echo "Start work with this URL: "$1"."
else
        echo "I need username and repo. Please, take me URL https://github.com/user/repository."
exit
fi

if (echo "$1" | grep -E -q "^.{1,100}$");
then
       url=$1
# construct link
name=$(echo "$url" | cut -d '/' -f 4)
repo=$(echo "$url" | cut -d '/' -f 5)
else
       name=mozilla-mobile
       repo =firefox-ios
       echo "You not set correct URL. I will use default name and repo."
fi

# ==(no use)==============
# https://github.com/mozilla-mobile/firefox-ios/
# target-link=$(echo "https://api.github.com/repos/$name/$repo/pulls?q=state%3Aopen")
# short link          https://api.github.com/repos/$name/$repo/pulls?state=open
# example # https://api.github.com/repos/mozilla-mobile/firefox-ios/pulls?q=state%3Aopen

if [ -r ./pulls.json ]; then
rm -rf pulls.json
else
echo "Your old Json file already does not exist!" # it is real evil thing
while true; do
    read -p "Do you wish to download this file?(Y/N) " yn
    case $yn in
        [Yy]* ) echo "I try download..."; curl -s https://api.github.com/repos/$name/$repo/pulls?q=state%3Aopen > ./pulls.json; break;;
        [Nn]* ) echo "Hasta la vista "; exit;;
        * ) echo "Please answer (Y)yes or (N)no. ";;
    esac
done
fi

echo "get data from file..."
raw_tab=$(jq '.[].user.login' pulls.json)
echo "sorting data..."
user_tab=$(echo "$raw_tab" | sort | uniq -c | sort -r | grep -v "      1 " )

echo "***************************************************"
echo "Top list:"
echo "Num of PR / Nickname"
echo "$user_tab"
echo "***************************************************"

title_tab=$(jq '.[].title' pulls.json)

name_title_tab=$(paste <(echo "$raw_tab") <(echo "$title_tab"))

users_tab=$(echo "$user_tab" | cut -d '"' -f 2 )

for name in $users_tab
	do
		echo "===================================================="
		echo  "PR of $name :"
		echo "$name_title_tab" | grep "$name"
		echo "===================================================="
	done
echo "Profit!"
rm -rf pulls.json
exit
