#!/bin/bash

#help
if [ "$1" = "-h" ]; then
echo "Hello! This script work with data from https://yandex.ru/news/quotes/ .
If you allow it can download data and tell you which March the price was the least volatile since 2015.
To do so you'll have to find the difference between MIN and MAX values for the period."
exit 0
fi

# it is plan
echo "Hello!"
# 0. check  quotes.json
if [ -r ./quotes.json ]; then
echo "Cool! Файл существует!"
echo "..."
else
echo "Hmm... Файл нe существует! :-)"
while true; do
    read -p "Do you wish to download this file?(Y/N) " yn
    case $yn in
        [Yy]* ) curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json; break;;
        [Nn]* ) echo "Hasta la vista "; exit;;
        * ) echo "Please answer (Y)yes or (N)no. ";;
    esac
done
fi

