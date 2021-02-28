#!/bin/bash

#help


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
