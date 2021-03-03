#!/bin/bash


if [ "$1" = "-h" ]; then
echo "Hello! This script work with data from https://yandex.ru/news/quotes/ .
If you allow it can download data and tell you which March the price was the least volatile since 2015.
To do so you'll have to find the difference between MIN and MAX values for the period."
exit 0
fi

echo "Hello!"

if [ -r ./quotes.json ]; then
echo "The data file is exist. Good. We migth work..."

raw_date_tab=$(jq -c '.prices[][0]' quotes.json | awk '{$1 = $1/1000} {print $1}' )

for dat in $raw_date_tab;
do
date_tab+=$(date  -d @$dat  "+%m-%Y%t")
done
dat_tab=$(echo $date_tab | sed 's/\s\+/\n/g')

val_tab=$(jq -c '.prices[][1]' quotes.json | awk '{print $1}' )

# ------ it working! do not edit!
#dvt=$(paste <(echo "$dat_tab") <(echo "$val_tab"))
#echo "$dvt"
#echo "Data filtering..."


 join <(echo "$dat_tab") <(echo "$val_tab")

# -------------------  not work
#dvt=$(join --header --nocheck-order <<<((${date_tab[*]})) <<<((${val_tab[*]})))
#echo "++++++ $dvt"

#date_val_tab=($(echo "${date_tab[*]}") $(echo "${val_tab[*]}"))
#echo "$date_val_tab"

# ---- wrong way
#new=("${date_tab[@]}" "${val_tab[@]}")
#echo ${new[@]}


else
echo "Hmm... File does not exist! :-)"
while true; do
    read -p "Do you wish to download this file?(Y/N) " yn
    case $yn in
        [Yy]* ) echo "I try download..."; curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json; break;;
        [Nn]* ) echo "Hasta la vista "; exit;;
        * ) echo "Please answer (Y)yes or (N)no. ";;
    esac
done
fi

