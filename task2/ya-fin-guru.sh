#!/bin/bash

#help
if [ "$1" = "-h" ]; then

	echo "Hello! This script work with data from https://yandex.ru/news/quotes/ .
If you allow it can download data and tell you which March the price was the least volatile since 2015.
To do so you'll have to find the difference between MIN and MAX values for the period.
	exit 0

fi

# it is plan
echo "Hello!"
# 0. check  quotes.json
if [ -f ./quotes.json ]; then
echo "Файл существует!"
else
echo "Файл not существует! :-)"
fi

# 1. if no - Ask the user for download
# 1.1 - if user say yes - curl it and go 2.
# 1.2 - if user say no - echo bye and exit
# 2. magic

read -p 'Ask User: ' useranswer

echo $useranswer

# 1.1. download data
# curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json
