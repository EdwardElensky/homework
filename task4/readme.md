## flask-app.py - it is my python3 flask application 

## Requirements
* OS Lunux
* Python 3
* Flask

## How it run:
* ``python3 flask-app.py``
* it avialable in your browser on 1080 port (after deploing it will change on 80 port)

## How it use
* do request:
* ``curl -XPOST -d'{"word":"trophy", "count": 4}' http://yourhost:1080/ ``
* and take answer:
* 🏆trophy🏆trophy🏆trophy🏆trophy🏆

--------------------



## Ansible assignment

## install
* Обновляем список репозиториев ``apt-get update``
* Пробуем установить пакет из репозитория ``apt-get install ansible``
* Затем проверяем версию ``ansible —version``
* Переходим в каталог с конфигурационными файлами  ``cd /etc/ansible/``
* Просматриваем основной конфиг ``less ansible.cfg``
* самым важным является ``hostfile = /etc/ansible/hosts`` , определяющим из какого файла будет браться список хостов на который распространяется конфигурация
* Открываем файл ``/etc/ansible/hosts`` на редактирование и добавляем в него доменные имена или IP адреса нод, которыми будем управлять при помощи Ansible, в файле добавляется имя секции хостов — например [servers], которой потом будем обращаться
``nano /etc/ansible/hosts``
* генерируем ключи и отправляем публичный ключ на все сервера, которые были добавлены в hosts на предыдущем шаге
``ssh-keygen`` 
``ssh-copy-id 123.123.123.123
ssh-copy-id 123.123.123.124
ssh-copy-id 123.123.123.125``
* Если возникают ошибки может потребоваться установить некоторые дополнительные пакеты
``apt-get install libffi-dev g++ libssl-dev`` ``pip install pyopenssl pyasn1 ndg-httpsclient cryptography cryptography``
* Попробуем вывести в консоль hostname всех серверов из hosts
``ansible -m shell -a 'hostname' all``
* Теперь можно (но не нужно, т.к. будем использовать .yml файл) отправить какой-то исполняемый файл на все сервера указав его расположение на текущем сервере и расположение на серверах, куда он отправляется ``ansible web -m copy -a «src=/etc/ansible/test.php dest=/home»``
* Когда создан корректный .yml файл можно конфигурацию применить ко всем серверам выполненяя команду: ``ansible-playbook -K main.yml``

---------





### The operating stage:
* create an ansible playbook that deploys the service to the VM
* make sure all the components you need are installed and all the directories for the app are present
* configure systemd so that the application starts after reboot
* secure the VM so that our product is not stolen: allow connections only to the ports 22,80,443. Disable root login. Disable all authentication methods except 'public keys'.
* bonus points for SSL/HTTPS support with self-signed certificates
* bonus points for using ansible vault

### Hints
* task:verify
* iptables, sshd_config
* good luck! ¯\_(ツ)_/¯



### Операционный этап:
* создать доступный playbook, который развертывает сервис на виртуальной машине
* убедитесь, что все необходимые компоненты установлены и все каталоги для приложения присутствуют
* настроить systemd так, чтобы приложение запускалось после перезагрузки
* защитить виртуальную машину от кражи нашего продукта: разрешить подключения только к портам 22,80,443. Отключить вход root. Отключите все методы аутентификации, кроме «открытых ключей».
* бонусные баллы за поддержку SSL / HTTPS с самоподписанными сертификатами
* бонусные баллы за использование доступного хранилища

### Подсказки
* задача: проверить
* iptables, sshd_config
* удачи! ¯ \ _ (ツ) _ / ¯
