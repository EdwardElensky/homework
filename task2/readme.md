## Requirements

* Linux
* bash
* curl
* jq

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
Its all. (More you will see in code)
