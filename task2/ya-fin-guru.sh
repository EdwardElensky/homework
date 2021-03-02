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

# jq -j '.prices[][0] |= (. / 1000 | strftime("%Y%m"))' quotes.json
# jq -r '.prices[][0] |= (. / 1000 | date -d @$((()/1000)) "+%m-%Y"' quotes.json
# jq -r '.prices[][]' quotes.json | awk 'NR%2 {$1 = $1/1000} {print $1, NR}'


raw_date_tab=$(jq -c '.prices[][0]' quotes.json | awk '{$1 = $1/1000} {print $1}' )
#echo "$raw_date_tab"
#date_tab=$(date -d @1614372599 "+%m-%Y")


val_tab=$(jq -c '.prices[][1]' quotes.json | awk '{print $1, NR}' )
# echo "$date_tab"

# date_tab="$( date "+%m-%Y" --date=@1614372599)"
# echo "$date_tab"

# --------------- worked
#for dat in {$raw_date_tab};
#do
#date  -d @$dat  "+%m-%Y"
#done

#------------ bad work
#while read dat;
#do
#    date_tab+="$( date -d @$dat "+%m-%Y");"
#done <<< "$raw_date_tab"

#echo "$date_tab"

# -----------bad
#dateval=$(paste "$date_tab" "$val_tab")
#echo "$dateval"

for dat in $raw_date_tab;
do
test100500+=$(date  -d @$dat  "+%m-%Y%t")
done
echo $test100500 | sed 's/\s\+/\n/g'



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

