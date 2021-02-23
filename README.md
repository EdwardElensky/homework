# Предварительная настройка ОС 
## (это не совсем ридми, но тоже гуд)

## 0. Установка SUDO
Перейти в консоль суперпользователя командой: 
```su```
Затем установить утилиту: 
```apt install sudo```

## 1. Добавить текущего пользователя в группу sudo: 
```sudo usermod -aG sudo```
Чтобы изменения вступили в силу нужно перелогиниться, далее можно пользоваться sudo.

## 2. Поставить гостевые дополнения ВБокса (опционально, в любой момент)
```cd /media/cdrom0```
```sudo sh VBoxLinuxAdditions.run```
```reboot```

## 3. Обновление системы :
```sudo apt update```
```sudo apt upgrade```

## 4. Настройка статического IP  (тут я клонировал вм в таргет, но можно было позже)
DHCP это замечательно, но нужно назначить статический ip (static ip) адрес. 
Воспользуемся для этого утилитой ip. 
Сначала посмотрим список всех сетевых интерфейсов, чтобы узнать название необходимого:
```ip a```
А потом просто редактируем файл, который отвечает за сетевые настройки - /etc/network/interfaces. 
```nano /etc/network/interfaces```
Для того, чтобы назначить постоянный статический ip адрес, в interfaces добавить строки: 
`auto enp0s3`  (интерфейс необходимо запускать автоматически при загрузке системы)
`iface enp0s3 inet static`  (интерфейс enp0s3 находится в диапазоне адресов IPv4 со статическим ip)
`address 192.168.0.50` (статический ip адрес)
`gateway 192.168.0.1`  (шлюз по-умолчанию)
`netmask 255.255.255.0` (24-я маска сети)

Для проверки перезагружаем и смотрим, все ли в порядке. 

## 5. Указать DNS сервер
Для того, чтобы указать dns сервер, достаточно его записать в файл /etc/resolv.conf :

```nano /etc/resolv.conf```

`nameserver 192.168.0.1` - локальный dns сервер
`nameserver 77.88.8.1` - публичный сервер Яндекса
`nameserver 8.8.4.4` - публичный сервер Гугла
`nameserver 1.1.1.1` - публичный сервер cloudflare

Если стоит resolvconf, то адрес dns сервера необходимо указать в файле /etc/network/interfaces, добавив к параметрам интерфейса еще один:
```dns-nameservers 192.168.1.1 77.88.8.1 8.8.4.4 1.1.1.1```
Этот параметр нужно установить сразу после указания шлюза gateway. Несколько адресов разделяются пробелом.

## 6. Изменить hostname (имя хоста)
Во время установки debian уже указывал имя хоста. 
Посмотреть его текущее значение можно в консоли:
```hostname```
```deb-host```
Это значение записано в файле /etc/hostname. 

Есть 2 способа изменить hostname в debian:
Временный - с помощью команды. 
```hostname debian10```

Постоянный - с помощью изменения конфигурационного файла. 
```nano /etc/hostname```

Чтобы сразу применить изменение, - выполнить команду
```hostnamectl set-hostname debian10```

## 7. Ставим полезный софт (или не ставим)
```sudo apt-get install curl```
```sudo apt install net-tools```
```sudo apt install netcat```
```sudo apt install nmap```
проверяем (или не проверяем)
```curl -4 wttr.in/Vitebsk```
```nmap -version```
```netcat -help ```
 
## 8. Настраиваем SSH
```sudo nano /etc/ssh/sshd_config```
(порт поменял и на хосте и на таргете, думал рут-логин отключить но он и так отключен)
перезагрузка
```systemctl reboot```
генерим ключи
```ssh-keygen```
передаем ключ на таргет
```ssh-copy-id -p 22051 user@192.168.0.51```
пробуем подключиться к таргету
```ssh -p 22051 user@192.168.0.51```

если всё работает - логин по ключу оставлем, пасс-логин запрещаем, 
на таргете
```sudo nano /etc/ssh/sshd_config```  
 

## 9. Правим настройку иксов для передачи по SSH
added on client configuration file /etc/ssh/ssh_config this line :
```   XAuthLocation /usr/bin/xauth```
```   ForwardAgent yes```
```   ForwardX11 yes```
```   ForwardX11Trusted yes```
   
терерь логинимся на таргет так:
```ssh -XC -p 22051 user@192.168.0.51```
и можем запускать ПО с ГУИ (например firefox)

ЗЫ: прокинуть иксы с таргета на мак не получилось :(
(xauth не проходит, и какой монитор тоже не понимает)
   

## 10. Ставим ГИТ  

```sudo apt-get update```
```sudo apt-get install git```

открываем пустой конфиг
```nano ~/.gitconfig```
и пишем - копипастим (алиасы по желанию)
```[user]
    name = Ed Elensky
    email = mymail@gmail.com

[color]
        ui = true

[core]
        autocrlf = input
        safecrlf = warn
        quotepath = off
[alias]
        lg1 = log --graph --all --format=format:'%C(bold blue)%h%C(reset)  ^`^t %C(bold green)(%ar)%C(reset) %$
        lg2 = log --graph --all --format=format:'%C(bold blue)%h%C(reset)  ^`^t %C(bold cyan)%aD%C(reset) %C(b$
        lg = !  git lg1
        hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
[init]
        defaultBranch = main
```

## 11. Подключаем ГИТ к репозиторию на github.com

читаем ключ (можно было новый сгенерить) и несем в профиль на гите.
```sudo cat ~/.ssh/id_rca.pub```

готовим папку (git init не делаем т.к. клонируем, а не создаем)
```mrdir homework```

клонируем 
```git clone git@github.com:EdwardElensky/homework.git homework```

## 12. Делаем заготовку под домашку (краткий алгоритм)
tasks = [1,2,3,4]
for n in tasks:
```	git checkout -b task(n)
	mkdir task(n)
	touch task(n)/readme.md
	nano task(n)/readme.md
	input some text
	git add task(n)/*
	git commit -m 'add readme.md'
	git push --set-upstream origin task(n)
```
Получилось четыре отдельных ветки для четырех заданий с разными директориями и одинаковыми файлами.
конфликтов при вероятном слиянии, если что, не будет.
