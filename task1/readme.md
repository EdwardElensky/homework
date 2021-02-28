## Info:
This script will get connection-list for any application from ```ss``` util and show the names of organizations from ```whois```.

## Requirements
* any Linux OS
* connection with Internet network
* bash
* ss
* whois

## How it run
* This script do not use any tmp files for work
* Just type in directory with this script ```sh whois-connect.sh [app name] [number of result]```
* You also can copy whois-connect.sh in ```/usr/local/bin``` and run script ```whois-connect.sh  [app name] [number of result]```
* Example:```whois-connect.sh opera 5```, ```whois-connect.sh chrome 20``` or ```whois-connect.sh nginx 99``` etc.
* If you run this script without any parametres or wrong parametres it will work with default parametres ```firefox 5```

## How script works
* Script use two argument for work.
* If user run script with key [-h] script take small help info.
* After run script will check start parametres.
* 1th parameter - Name of process - length 1-30 simbols (if wrong - use default name "firefox")
* 2th parameter - Number of cheking IP - only numbers (if wrong - use defaut numbers "5")
* get data from ```ss``` util  (with -tunap)
* use ```awk```util as filter with app name (```awk '/'${proc}'/ {print $6}'```)
* cut port number (```cut -d: -f1```)
* sort list (```uniq -u```) instead ```sort | uniq -c```
* take from the list last n ip (```tail -n "$num_ip"```)
* check ip table with ip regular expression ```grep -E "((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])")```
* use ```whois``` for ip and get whois data
* use ```awk``` as filter and get Organization Netname from whois data
* display result on screen
* profit!

# Назначение сценариев 
*/недоперевод, возможно, потом уберу/*
## Превратите этот однострочник в красивый скрипт:
```sh
sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done
```
# РЕШЕНИЕ и АНАЛИЗ ЗАДАНИЯ
## разберем, что тут происходит:

* sudo - выполнять команды от имени суперпользователя (повышаем права перед выполнением команд)

* netstat - утилита командной строки выводящая на дисплей состояние сетевых соединений (буду менять на SS)
*  -t  show tcp connections
*  -u  show tcp connections
*  -n  show numerical addresses instead of trying to determine symbolic host, port or user names
*  -a  show both listening and non-listening sockets
*  -p  show the PID and name of the program to which each socket belongs
*  -l  Show only listening sockets.  (These are omitted by default.)
  
* awk  утилита/язык для извлечения данных
*  '/firefox/ {print $5}' по шаблону "firefox" печатает элементы только пятой колонки (можно не прибивать гвоздями спрашивать при запуске)
  
* cut remove sections from each line of files (обрезка)
*  -d: delimiter, use DELIM instead of TAB for field delimiter 
*  -f1 select  only these fields;  also print any line that contains no delimiter character
  
* sort - sort lines of text files  (не ясно, зачем)(уже ясно, так легче делать uniq без параметров если список большой)
* uniq - report or omit repeated lines (не ясно зачем, почему не uniq -u ?)
*  -c prefix lines by the number of occurrences
  
* sort - sort again (эх раз, еще раз)
* tail - output the last part of files (забираем 5 строк с конца списка, может лучше спрашивать при запуске)
*   -n5 - last 5 lines of file   
### Я бы поменял местами grep и tail т.к. правильнее сначала получить валидные данные а потом сортировать их. 
### В исходном варианте может получаться вывод меньшего количества значений чем задано n что даст неверную инфу юзеру.  
* grep - print lines that match patterns  (грепаем то, что осталось, регулярка проверяет "похожесть на айпишник"
*  -o Print  only  the  matched  (non-empty)  parts of a matching line, with each such part on a separate output line.  
*  -P Interpret PATTERNS as Perl-compatible regular expressions  (PCREs), and grep -P may warn of unimplemented features.
*  '(\d+\.){3}\d+'  - проверка адресов по регулярному выражению
* while read IP ; do whois $IP  - цикл, дословно, пока в списке есть IP - делаем whois т.е. проверяем список адресов whois
* awk - еще раз извлекаем данные из списка
*  -F':' '/^Organization/ {print $2}' ;  выбираем 2ю колонку - организации (она кстати может быть пустая, т.к. хуиз не всегда заполнен)
*  done (усё)  

PS
* Поскольку однострочник не юзает файловую систему, ничего не сохраняет на винт и не пихает данные в стандартные потоки я буду делать также.
* Никаках промежуточных файлов, всё храним в переменных. Переменные разные а не одна перезаписываемая. 
* (так удобнее допиливать и обвешивать фичами, если что)
* Сначала хотелось реализовать полноценный диалоговый режим (пошаговый мастер, ввод данных от пользователя).
* Но это помешает автоматическому запуску скрипта (например кроном). Поэтому сделал так как сделал.
