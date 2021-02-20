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

## Станьте финансовым гуру
`` sh
# Скачать базу данных
curl -s https://yandex.ru/news/quotes/graph_2000.json> ./quotes.json
``
Теперь у вас есть исторические котировки пары EUR / RUB с конца ноября 2014 года. Пришло время повеселиться:
`` sh
# получим среднее значение за последние 14 дней и решим, покупать ли евро:
jq -r '.prices [] []' quotes.json | grep -oP '\ d + \. \ d +' | хвост -n 14 | awk -v mean = 0 '{mean + = $ 1} END {print mean / 14}'
``
* попробуйте понять команду выше. Прочтите что-нибудь связанное с `jq` и` awk`.
* удалите часть `grep -oP '\ d + \. \ d +' ', сделайте то же самое без сопоставления с образцом
* скажите, в каком марте цена была наименее волатильной с 2015 года? Для этого вам необходимо найти разницу между значениями MIN и MAX за период.

### Подсказки
* man date
* Яндекс любит нули!


