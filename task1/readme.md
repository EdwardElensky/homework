# Scripting assignments
## Turn this one-liner into a nice script:
```sh
sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done
```
* 1 point for parametrization: you might want to enter PID or name of another process as an argument
* 1 point for parametrization: you might want to see more results
* 1 point for parametrization: you might want to see other connection states
* 1 point for securing script execution and nice error messages
* 2 points for writing a README.md for what your script does
* 2 points for adding count of connections per organization to the final output
* 2 points for rewriting the functionality differently, say using `ss`, `sed`, built-ins like `"${VAR%%:*}"` (might be a separate script)

### Hints
* you probably should start with `sudo netstat -tunapl | less` # mnemonic is 'tuna, please'
* progress through pipes until it becomes clear what the thing is doing


# Назначение сценариев
## Превратите этот однострочник в красивый скрипт:
`` sh
sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done
``
* 1 балл за параметризацию: вы можете указать PID или имя другого процесса в качестве аргумента
* 1 балл за параметризацию: возможно, вы захотите увидеть больше результатов
* 1 балл за параметризацию: вы можете захотеть увидеть другие состояния подключения
* 1 балл за обеспечение безопасности выполнения скрипта и приятные сообщения об ошибках
* 2 балла за написание README.md того, что делает ваш скрипт
* 2 балла за добавление количества подключений на организацию к окончательному результату
* 2 балла за переписывание функциональности по-другому, скажем, с использованием `ss`,` sed`, встроенных функций, таких как `" $ {VAR %%: *} "` (может быть отдельным скриптом)

### Подсказки
* вам, вероятно, следует начать с `sudo netstat -tunapl | less` # мнемоническое слово - "tuna, пожалуйста"
* продвигайтесь по pipes, пока не станет ясно, что происходит

# РЕШЕНИЕ
## разберем, что тут происходит:

sudo - предоставляет возможность пользователям выполнять команды от имени суперпользователя (повышаем права перед выполнением команд)

netstat - утилита командной строки выводящая на дисплей состояние сетевых соединений
  -t  show tcp connections
  -u  show tcp connections
  -n  show numerical addresses instead of trying to determine symbolic host, port or user names
  -a  show both listening and non-listening sockets
  -p  show the PID and name of the program to which each socket belongs
  -l  Show only listening sockets.  (These are omitted by default.)
  
awk  утилита/язык для извлечения данных
  '/firefox/ {print $5}' по шаблону "firefox" печатает элементы только пятой колонки
  
cut remove sections from each line of files
  -d: delimiter, use DELIM instead of TAB for field delimiter
  -f1 select  only these fields;  also print any line that contains no delimiter character
  
sort - sort lines of text files
uniq - report or omit repeated lines
  -c prefix lines by the number of occurrences
  
sort - sort again
tail - output the last part of files
  -n5 - last 5 lines of file
  
grep - print lines that match patterns
  -o Print  only  the  matched  (non-empty)  parts of a matching line, with each such part on a separate output line.  
  -P Interpret PATTERNS as Perl-compatible regular expressions  (PCREs), and grep -P may warn of unimplemented features.
  '(\d+\.){3}\d+'  - проверка адресов по регулярному выражению
while read IP ; do whois $IP  - цикл, дословно, пока в списке есть IP - делаем whois т.е. проверяем список адресов whois
awk - еще раз извлекаем данные из списка
  -F':' '/^Organization/ {print $2}' ; done 
