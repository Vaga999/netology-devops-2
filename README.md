# Домашнее задание к занятию "5.5. Оркестрация кластером Docker контейнеров на примере Docker Swarm"



## Задача 1

Дайте письменые ответы на следующие вопросы:

- В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?  
    replication - этот режим позволяет определить количество экзэмпляров сервиса которое необходимо запустить, что позволяет не перегружать другие узлы кластера. Например мы можем заустить сервис "Ы" на 5 из 10 узлах.(распределяет определенное количество задач реплики между узлами)    
    global - этот режим запускает сервис на всех узлах доступных в кластере, даже если мы добавим в кластер новый узел , на нем запустится задача для которой поставлен режим global.  

- Какой алгоритм выбора лидера используется в Docker Swarm кластере?  
    Алгоритм поддержания распределенного консенсуса (Raft?). Суть в том, что если в кластере нет лидера , то узлы голосуют за до тех пор покак кандидат не станет лидером. Если он перестанет быть лидером (отключится) то происходят повторные выборы. (http://thesecretlivesofdata.com/raft/)


- Что такое Overlay Network?  
    Сеть всегда была самой инертной частью любой системы. 
    Большинство сетей сегодня можно явно разбить на две части:
       Underlay — физическая сеть со стабильной конфигурацией.  
       Overlay — абстракция над Underlay для изоляции сервиса или отдельного клиента. Overlay — виртуальная сеть туннелей, натянутая поверх Underlay, она позволяет ВМ одного клиента общаться друг с другом, при этом обеспечивая изоляцию от других клиентов. Данные клиента инкапсулируются в какие-либо туннелирующие заголовки для передачи через общую сеть. Так ВМ одного клиента (одного сервиса) могут общаться друг с другом через Overlay, даже не подозревая какой на самом деле путь проходит пакет. 

## Задача 2

Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker node ls
```
Сделано:  

![](https://s812sas.storage.yandex.net/rdisk/821cdd86515cc7bc0faa9f2b67c6b291b122ba3b45a090d29275de308107b4b4/625c07a5/-yg_cLuuhfuAgJu7cu40CswajWKOUAAtDndSPPnGq1JTILlzHb0-nVTXust0PK2uPdCNhpvOkej6I_tgnBjzQA==?uid=160010782&filename=1%D0%99.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=204826&hid=b319114e0ccf769834bd22dc9132646c&media_type=image&tknv=v2&etag=b28e410b23e7b573eae143f19ff61e72&rtoken=ZRemq5Gelk1T&force_default=yes&ycrid=na-7fe2c5fdf20c9f0c270ec6e8df42ba6d-downloader10e&ts=5dcd8c3a57340&s=38c5f4ca95b4e4aa5630bb927a48dee42de26fcfdbe76888ee3438a099e0b05b&pb=U2FsdGVkX19r55Ji_lOlKS68Bg1MQ_rJUN_n95vyUUpA5wGk1JufDxVSVNgdQBo6eNdncOSnStqrYW5LTFsgsSABSOqiwVQo4hG5zb4MAXg)  
## Задача 3

Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker service ls
```
Сделано:  

![](https://s812sas.storage.yandex.net/rdisk/821cdd86515cc7bc0faa9f2b67c6b291b122ba3b45a090d29275de308107b4b4/625c07a5/-yg_cLuuhfuAgJu7cu40CswajWKOUAAtDndSPPnGq1JTILlzHb0-nVTXust0PK2uPdCNhpvOkej6I_tgnBjzQA==?uid=160010782&filename=1%D0%99.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=204826&hid=b319114e0ccf769834bd22dc9132646c&media_type=image&tknv=v2&etag=b28e410b23e7b573eae143f19ff61e72&rtoken=ZRemq5Gelk1T&force_default=yes&ycrid=na-7fe2c5fdf20c9f0c270ec6e8df42ba6d-downloader10e&ts=5dcd8c3a57340&s=38c5f4ca95b4e4aa5630bb927a48dee42de26fcfdbe76888ee3438a099e0b05b&pb=U2FsdGVkX19r55Ji_lOlKS68Bg1MQ_rJUN_n95vyUUpA5wGk1JufDxVSVNgdQBo6eNdncOSnStqrYW5LTFsgsSABSOqiwVQo4hG5zb4MAXg)  
