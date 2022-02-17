# Домашнее задание к занятию 5.2. Применение принципов IaaC в работе с виртуальными машинами.  

## Вопрос 1. 
### Опишите своими словами основные преимущества применения на практике IaaC паттернов.  
* Управление через конфиг файлы и скрипты позволяет быстро получать едентичный результат на множестве машин.  
* Сведение вероятности ошибки к минимуму.  
* Увеличение скорости развертывания окружения.

### Какой из принципов IaaC является основополагающим?  
Стабильность результата, повышение гибкости и эффективности.

## Вопрос 2.
* ### Чем Ansible выгодно отличается от других систем управление конфигурациями?  
    Возможность использовать существующую инфраструктуру SSH (т.е.  не надо на каждую систему ставить клиент)  
* ### Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?  
Выделить лучший или худший метод думаю является не разумным , т.к. выбор будет зависить от того какое окружение стоит. И только после проверки в конкретном окружении  можно сказать что более предпочтительнее. Поэтому не могу дать однозначный ответ на этот вопрос , да и опыта маловато.   
Для себя бы я начал с push.  

## Вопрос 3. 
### Установить на личный компьютер:

VirtualBox    
Сделано:  
![](https://s796sas.storage.yandex.net/rdisk/a13714d7b1efc9d62987a2bfaf31a9aea38cf977f955014204ba5db2c30a96ee/620e7878/-yg_cLuuhfuAgJu7cu40CpQpixikgk21dEZDtHDshhHT4GawVnTRl4GzYjOX9tTpco-q-JDBQMfikqn8vizrhA==?uid=160010782&filename=VBox.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=74783&hid=b8dd22d3e1db6d1685c78212f52a295c&media_type=image&tknv=v2&etag=69f36008c92df6edb544fb1e380da1cc&rtoken=dtANyZIA6h10&force_default=yes&ycrid=na-14a622513c2c1dfdcc07903d96baa5a7-downloader4e&ts=5d8394db50e00&s=c421d9746c294b01fde4ad57f90676f57bbceed055770c0eac140f51098880e4&pb=U2FsdGVkX18w7QaAfmavDTkPJ9fKqHcacJ4J38JismlWGHn3c5JSp_hOu-NEfX--ionmlCMzvXYi32KLB5rzmq7XYj83ovlF4HeKv6A4lXY)  
Vagrant      
Сделано:   
![](https://s502man.storage.yandex.net/rdisk/4ce2b721c1a855bce5808687321b63e032b745aea1dc5ee8bff7d57473ce778d/620e781e/-yg_cLuuhfuAgJu7cu40Cp7RSLpePC6ldqcBBJx6rZ85VYHhcFXfINDc9bSRMpIYvTw2F8UU47Zg_TSQW5T9Ow==?uid=160010782&filename=vagrant.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=17335&hid=24dfaa821367a2590ee90c27ff9c5b19&media_type=image&tknv=v2&etag=96acd5b708bca12e12185b3e070bf5a2&rtoken=CiBAi0Rni7Yz&force_default=yes&ycrid=na-67e70874006ac71130150c5b210650fa-downloader4e&ts=5d8394857c380&s=84ba8e94889f19316e156d69a4325ff260c5b9bf5ef36f01ae96936e609e78a8&pb=U2FsdGVkX1-UeCDG4odP6-GlPkAMpoKnb6Q17GwFzu9JbKCriN03klaRm6sdook3jlqbXe-HARPOGwGyok_p7ZdoceQEWCiBk3AKndo8RP8)  
Ansible    
Сделано:   
![](https://s576sas.storage.yandex.net/rdisk/8628155e721a5986f8dcac861e90460d87edf54b96e5ab5ffd4c6340913d350a/620e773f/-yg_cLuuhfuAgJu7cu40Cm7ZpgP7dbPjdlg4ICdwLTRsgNL6z-gqF2kOKXRRU_WusstqA3JEj3Wwy9wZCDlLJg==?uid=160010782&filename=Ansible.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=57813&hid=599a07d4050fb38de988e25aef2d921e&media_type=image&tknv=v2&etag=e0a014f025d1aff5da95bcfe972a1010&rtoken=X9RDdNbNMarO&force_default=yes&ycrid=na-8660db482f5c60ea87ce8b7da4667a73-downloader6f&ts=5d8393b0d0dc0&s=32b8850719992910171a1df8fc7bed922bb91ef6803c50d710761c04add2a283&pb=U2FsdGVkX18jjljW4pyW-sVQCXCjcqTYU01RsOyXPuAHLmVAAaRwzYOZ5L5v0xNx3mE1R_eQ2xI6hH8Zh-S345JE7Mwaf7OYb866i4hP-zM)  

