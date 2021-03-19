#!/bin/bash
# ============================== help section
if [ "$1" = "-h" ]; then
echo "Hello! This script work with data from https://yandex.ru/news/quotes/ .
If you allow it can download data and tell you which March the price was the least volatile since 2015.
To do so you'll have to find the difference between MIN and MAX values for the period.
Script need from you number of month for calculate. Example - ya-fin-guru.sh 05"
exit
fi
# ============================== set month for calculate
if (echo "$1" | grep -E -q "^(0[1-9]|1[0-2])$");
then
        month=$1
else
	month="03"
  echo "You not set correct month. I will calculate values for marth."
fi
echo "Hello! Calculating for "$month"-th month."
# ============================== get json
if [ ! -r ./quotes.json ]; then
echo "Hmm... Json file does not exist! :-)"
while true; do
    read -p "Do you wish to download this file?(Y/N) " yn
    case $yn in
        [Yy]* ) echo "I try download..."; curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json; break;;
        [Nn]* ) echo "Hasta la vista "; exit;;
        * ) echo "Please answer (Y)yes or (N)no. ";;
    esac
done
# ============================== create tempdir
else
echo "07%... The json file is exist. Good. We will work..."
TMPDIR=".${0##*/}-$$" && mkdir -p "$TMPDIR"
# echo "formating harddrive..."
# sleep 5s #ha ha ha
# echo "formating complete!"
# ============================== parse dates from fson
echo "19%... get dates from file..."
raw_date_tab=$(jq -c '.prices[][0]' quotes.json | awk '{$1 = $1/1000} {print $1}' )
# ============================== convert dates
# echo "27%... convert dates..."
for dat in $raw_date_tab;
do
date_tab+=$(date  -d @$dat  "+%m-%Y%t")
done
dat_tab=$(echo $date_tab | sed 's/\s\+/\n/g' | sed 's/-\+/ /g' )
# ============================== parse values from json
echo "41%... get values from file..."
val_tab=$(jq -c '.prices[][1]' quotes.json | awk '{print $1}' )
# ============================== split dates and values in new table
echo "59%... merge dates and values..."
dvt=$(paste <(echo "$dat_tab") <(echo "$val_tab"))
# ============================== get from table only needed months
echo "73%... data filtering..."
filt_m=$(grep "$month " <(echo "$dvt"))
# ============================== divided table by years and put data in separated tempfiles
echo "88%... separate data by month..."
separate_month=$(awk -v y="$TMPDIR" '{print y ; print $3 >>(y"/"$1"_"$2); close(y"/"1$"_"$2) }' <(echo "$filt_m"))
list_of_month=$(ls "$TMPDIR")
number_of_var=$(grep _ -c <(echo "$list_of_month"))
# ============================= calculate volatility and save in list
for months in $list_of_month;
    do
var=$(< "$TMPDIR"/$months)
sorted_var=$(echo "$var" | sort -n)
max_val_var=$(echo "$sorted_var" | tail -n 1)
min_val_var=$(echo "$sorted_var" | head -n 1)
vola_var=$(awk -v a="$max_val_v03_2015" -v b="$min_val_var" 'BEGIN{print (a+b)*0.5}')
list_of_vola+=""$vola_var"_the_minimum_volatility_was_in_"$months" "
# ============================== optional progress info
# echo "calculate volatility in $months (it was $vola_var) "
    done
# ============================== find minimal vola and show it
echo "100% complete!"
echo "$list_of_vola" | sed 's/\ \+/\n/g'|sort |head -n 2
echo "================================================"
# ============================== deleting tempfiles and tempdir

rm -r $TMPDIR

fi

exit
