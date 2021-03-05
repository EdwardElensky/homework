#!/bin/bash
# ==============================
if [ "$1" = "-h" ]; then
echo "Hello! This script work with data from https://yandex.ru/news/quotes/ .
If you allow it can download data and tell you which March the price was the least volatile since 2015.
To do so you'll have to find the difference between MIN and MAX values for the period.
Script need from you number of month for calculate. Example - ya-fin-guru.sh 05"
exit
fi
# ==============================
if (echo "$1" | grep -E -q "^(0[1-9]|1[0-2])$");
then
#so sorry  month=$1
	month="03" 
else
	month="03"
  echo "You not set correct month. I will calculate values for marth."
fi
echo "Hello! Calculating for "$month"-th month."
# ==============================
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
# ==============================
else
echo "The json file is exist. Good. We will work..."
TMPDIR=".${0##*/}-$$" && mkdir -v "$TMPDIR"
echo "formating harddrive..."
sleep 5s #ha ha ha
echo "formating complete!"
# ==============================
echo "get dates from file..."
raw_date_tab=$(jq -c '.prices[][0]' quotes.json | awk '{$1 = $1/1000} {print $1}' )
# ==============================
# echo "convert dates..."
for dat in $raw_date_tab;
do
date_tab+=$(date  -d @$dat  "+%m-%Y%t")
done
dat_tab=$(echo $date_tab | sed 's/\s\+/\n/g' | sed 's/-\+/ /g' )
# ==============================
echo "get values from file..."
val_tab=$(jq -c '.prices[][1]' quotes.json | awk '{print $1}' )
# ==============================
echo "merge dates and values..."
dvt=$(paste <(echo "$dat_tab") <(echo "$val_tab"))
# ==============================
echo "data filtering..."
filt_m=$(grep "$month " <(echo "$dvt"))
# ==============================
echo "separate data by month..."
separate_month=$(awk -v y="$TMPDIR" '{print y ; print $3 >>(y"/"$1"_"$2); close(y"/"1$"_"$2) }' <(echo "$filt_m"))
list_of_month=$(ls "$TMPDIR")
number_of_var=$(grep _ -c <(echo "$list_of_month"))

# ===== my terrible code========
v03_2015=$(< "$TMPDIR"/03_2015)
v03_2016=$(< "$TMPDIR"/03_2016)
v03_2017=$(< "$TMPDIR"/03_2017)
v03_2018=$(< "$TMPDIR"/03_2018)
v03_2019=$(< "$TMPDIR"/03_2019)
v03_2020=$(< "$TMPDIR"/03_2020)

sorted_v03_2015=$(echo "$v03_2015" | sort -n)
max_val_v03_2015=$(echo "$sorted_v03_2015" | tail -n 1)
min_val_v03_2015=$(echo "$sorted_v03_2015" | head -n 1)
vola_v03_2015=$(awk -v a="$max_val_v03_2015" -v b="$min_val_v03_2015" 'BEGIN{print (a+b)*0.5}')
list_of_vola+=""$vola_v03_2015"_volatility_of_03_2015 "

sorted_v03_2016=$(echo "$v03_2016" | sort -n)
max_val_v03_2016=$(echo "$sorted_v03_2016" | tail -n 1)
min_val_v03_2016=$(echo "$sorted_v03_2016" | head -n 1)
vola_v03_2016=$(awk -v a="$max_val_v03_2016" -v b="$min_val_v03_2016" 'BEGIN{print (a+b)*0.5}')
list_of_vola+=""$vola_v03_2016"_the_minimum_volatility_was_in_03_2016 "

sorted_v03_2017=$(echo "$v03_2017" | sort -n)
max_val_v03_2017=$(echo "$sorted_v03_2017" | tail -n 1)
min_val_v03_2017=$(echo "$sorted_v03_2017" | head -n 1)
vola_v03_2017=$(awk -v a="$max_val_v03_2017" -v b="$min_val_v03_2017" 'BEGIN{print (a+b)*0.5}')
list_of_vola+=""$vola_v03_2017"_the_minimum_volatility_was_in_03_2017 "

sorted_v03_2018=$(echo "$v03_2018" | sort -n)
max_val_v03_2018=$(echo "$sorted_v03_2018" | tail -n 1)
min_val_v03_2018=$(echo "$sorted_v03_2018" | head -n 1)
vola_v03_2018=$(awk -v a="$max_val_v03_2018" -v b="$min_val_v03_2018" 'BEGIN{print (a+b)*0.5}')
list_of_vola+=""$vola_v03_2018"_the_minimum_volatility_was_in_03_2018 "

sorted_v03_2019=$(echo "$v03_2019" | sort -n)
max_val_v03_2019=$(echo "$sorted_v03_2019" | tail -n 1)
min_val_v03_2019=$(echo "$sorted_v03_2019" | head -n 1)
vola_v03_2019=$(awk -v a="$max_val_v03_2019" -v b="$min_val_v03_2019" 'BEGIN{print (a+b)*0.5}')
list_of_vola+=""$vola_v03_2019"_the_minimum_volatility_was_in_03_2019 "

sorted_v03_2020=$(echo "$v03_2020" | sort -n)
max_val_v03_2020=$(echo "$sorted_v03_2020" | tail -n 1)
min_val_v03_2020=$(echo "$sorted_v03_2020" | head -n 1)
vola_v03_2020=$(awk -v a="$max_val_v03_2020" -v b="$min_val_v03_2020" 'BEGIN{print (a+b)*0.5}')
list_of_vola+=""$vola_v03_2020"_the_minimum_volatility_was_in_03_2020 "

echo "$list_of_vola" | sed 's/\ \+/\n/g'|sort |head -n 2
sorted_list_of_vola=$(echo "$list_of_vola" | sort )
min_vola=$(echo "$list_of_vola" | head -n 2)
# ========= end terrible code ==============

# ==I dont know how it do.( maybe later)==
# echo "$number_of_var"
#count="$number_of_var"
#for a in ${list_of_month[@]}; do
#    var=month_$count
#    eval $var=$a
#    eval echo \$$var
#echo ${list_of_month["$count"]}
#echo ""$TMPDIR"/"$list_of_month""
#echo ""$TMPDIR"/$(grep ${list_of_month[@]} <(echo "$TMPDIR"/"$list_of_month"))"
#    (( count-- ))

#    echo "$var"
#    cat <(echo "$TMPDIR/${list_of_month[@]}")
#done

#sorted_month=$(sort <(echo $TMPDIR/${list_of_month[@]})
#min_val=$(tail -n 1 <(echo $sorted_month))
#max_val=$(hesd -n 1 <(echo $sorted_month))
#vola=$(($max_val-$min_val)/2)


# ==============================

rm -r $TMPDIR

fi

exit
