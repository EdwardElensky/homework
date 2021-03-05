#!/bin/bash


if [ "$1" = "-h" ]; then
echo "Hello! This script work with data from https://yandex.ru/news/quotes/ .
If you allow it can download data and tell you which March the price was the least volatile since 2015.
To do so you'll have to find the difference between MIN and MAX values for the period.
Script need from you number of month for calculate. Example - ya-fin-guru.sh 05"
exit
fi

if (echo "$1" | grep -E -q "^(0[1-9]|1[0-2])$");
then
	month=$1
else
	month="03"
  echo "You not set correct month. I will calculate values for marth."
fi
echo "Hello! Calculating for "$month"-th month."


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


else
echo "The json file is exist. Good. We will work..."
TMPDIR=".${0##*/}-$$" && mkdir -v "$TMPDIR"
sleep 1s #ha ha ha
ls -ali $TMPDIR/

echo "get dates from file..."
raw_date_tab=$(jq -c '.prices[][0]' quotes.json | awk '{$1 = $1/1000} {print $1}' )


echo "convert dates..."
for dat in $raw_date_tab;
do
date_tab+=$(date  -d @$dat  "+%m-%Y%t")
done
dat_tab=$(echo $date_tab | sed 's/\s\+/\n/g' | sed 's/-\+/ /g' )


echo "get values from file..."
val_tab=$(jq -c '.prices[][1]' quotes.json | awk '{print $1}' )


echo "merge dates and values..."
dvt=$(paste <(echo "$dat_tab") <(echo "$val_tab"))


echo "Data filtering..."
filt_m=$(grep "$month " <(echo "$dvt"))

# echo "$filt_m"


awk -v '{ print $3 >>($TMPDIR/$1"-"$2); close($TMPDIR/1$"-"$2) }' <(echo "$filt_m")

ls -ali $TMPDIR/

# awk -v m=$[i*2-1] 'FNR == m {print $2}'

# берется среднее значение курса за март. 
# Затем, проверяется разность между средним значением и  минимальным и максимальным курсом за период (март). 
# И далее выбирается год, в который в марте разница была минимальна.
# mean — среднее
# max — максимальное
# min — минимальное
# volatility = ((mean - min) + (max - mean))/2




fi

exit
