# Ansible assignment
## Create and deploy your own service
### The development stage:
For the true enterprise grade system we will need Python3, Flask and emoji support. Why on Earth would we create stuff that does not support emoji?!

* the service listens at least on port 80
* the service accepts GET and POST methods
* the service should receive `JSON` object and return a string decorated with your favorite emoji in the following manner:
```sh
curl -XPOST -d'{"word":"evilmartian", "count": 3}' http://myvm.localhost/
💀evilmartian💀evilmartian💀evilmartian💀

curl -XPOST -d'{"word":"mice", "count": 5}' http://myvm.localhost/
🐘mice🐘mice🐘mice🐘mice🐘mice🐘
```
* bonus points for being creative when serving `/`

### Hints
* [installing flask](https://flask.palletsprojects.com/en/1.1.x/installation/#installation)
* [become a developer](https://flask.palletsprojects.com/en/1.1.x/quickstart/)
* [or whatch some videos](https://www.youtube.com/watch?v=Tv6qXtc4Whs)
* [dealing with payloads](https://www.digitalocean.com/community/tutorials/processing-incoming-request-data-in-flask)
* [Flask documentation](https://flask.palletsprojects.com/en/1.1.x/api/#flask.Request.get_json)
* what would you expect to see when visiting a random unknown website?

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

# Ответственное задание
## Создайте и разверните свой собственный сервис
### Этап разработки:
Для настоящей системы корпоративного уровня нам понадобится поддержка Python3, Flask и эмодзи. Зачем нам создавать вещи, которые не поддерживают эмодзи ?!

* сервис слушает хотя бы порт 80
* сервис принимает методы GET и POST
* сервис должен получить объект `JSON` и вернуть строку, украшенную вашими любимыми эмодзи следующим образом:

```sh
curl -XPOST -d'{"word":"evilmartian", "count": 3}' http://myvm.localhost/
💀evilmartian💀evilmartian💀evilmartian💀

curl -XPOST -d'{"word":"mice", "count": 5}' http://myvm.localhost/
🐘mice🐘mice🐘mice🐘mice🐘mice🐘
```
* бонусные баллы за творческий подход при обслуживании `/`

### Подсказки
* [установка flask] (https://flask.palletsprojects.com/en/1.1.x/installation/#installation)
* [стать разработчиком] (https://flask.palletsprojects.com/en/1.1.x/quickstart/)
* [или какие видео] (https://www.youtube.com/watch?v=Tv6qXtc4Whs)
* [работа с полезными нагрузками] (https://www.digitalocean.com/community/tutorials/processing-incoming-request-data-in-flask)
* [Документация Flask] (https://flask.palletsprojects.com/en/1.1.x/api/#flask.Request.get_json)
* что вы ожидаете увидеть при посещении случайного неизвестного веб-сайта?

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
