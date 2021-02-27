#!/bin/bash

# it is plan
# 0. check  quotes.json
# 1. if no - Ask the user for download
# 1.1 - if user say yes - curl it and go 2.
# 1.2 - if user say no - echo bye and exit
# 2. magic

read -p 'Ask User: ' useranswer

# 1.1. download data
# curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json
