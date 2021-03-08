## Become financial guru
```sh
# Download the database
curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json
```
Now you have historical quotes for EUR/RUB pair since late November 2014. It's time to have some fun:
```sh
# let's get the mean value for the last 14 days and decide whether to buy Euros:
jq -r '.prices[][]' quotes.json | grep -oP '\d+\.\d+' | tail -n 14 | awk -v mean=0 '{mean+=$1} END {print mean/14}'
```
* try to understand the command above. Read something related to `jq` and `awk`.
* remove the `grep -oP '\d+\.\d+'` part, do the same thing without any pattern matching
* tell me which March the price was the least volatile since 2015? To do so you'll have to find the difference between MIN and MAX values for the period.

### Hints
* man date
* Yandex likes zeroes!



## How it run
If you have internet or file quotes.json (from https://yandex.ru/news/quotes/graph_2000.json ) just run script ya-fin-guru.sh

## How it work
Script check file quotes.json in script directory.
If quotes.json does not exist script asks user for download it.
Them script create temp folder for temp files.
From quotes.json takes two rows (dates and values) preparing (convert date) and input in two variables.
Dates and values merging in one table, filtering and separating by files in temp directory.
Here started teribble code (almost beautifull function and while-cycle) Sorry.
For every file in TMPDIR calculate volatility and add in volatility-list
Sort of volatility-list, take the minimum value of volatility and show it.
Its all.
