# Домашнее задание к занятию 5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера  
 
## 1. Сценарий выполения задачи:

1) создайте свой репозиторий на https://hub.docker.com;  
2) выберете любой образ, который содержит веб-сервер Nginx;  
3) создайте свой fork образа;  
4) реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:    

        <html>
        <head>
        Hey, Netology
        </head>
        <body>
        <h1>I’m DevOps Engineer!</h1>
        </body>
        </html>

Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.  

1) сделано по инструкции https://hub.docker.com/r/ubuntu/nginx  
![](https://s253vla.storage.yandex.net/rdisk/bcebb370357d12186bea6be311d968152e5d0d5c58e18f8eb10d013218550d75/621fc635/-yg_cLuuhfuAgJu7cu40Cn087vdk3zEE18mGOrhRIRHWdAtlPMH04pkjvy7oq06MDhVlJCWjpgh3VHkkweoRbQ==?uid=160010782&filename=%D1%81%D0%BA%D1%80%D0%B8%D0%BD%201%20%D1%81%D1%82%D0%B0%D1%82%D1%83%D1%81%20.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=217572&hid=b5325bbc73a76b69a5519b92204f22d2&media_type=image&tknv=v2&etag=524dc9f477826a3b4d5ae25002e3b6ff&rtoken=dFbLjJaPbeUg&force_default=yes&ycrid=na-bda394e2606efaeaf9dbf1bd9a355f1a-downloader3e&ts=5d94156263740&s=03900ce09bdb98bd43f89227fe17851f3ab63fb9e46cb3850e6156af425abd96&pb=U2FsdGVkX1-zuSfiQsGidMl13K7U4tTeZ1HUOPoHV45KX9eT1L-b3XppMN3pUpoAUC8s9jElH3-lJsGiFgfejpQ4hwyyj3XOrupseFn6Lm8)
2) сделано. В выбран https://hub.docker.com/r/ubuntu/nginx
3) Тут возможно 2а пути либо  через докер файл, либо через сохранение изменений контейнера. Я использую сохранение изменений:


      vagrant@vagrant:/$ sudo docker run -d --name nginx-container-netology -e TZ=UTC -p 8080:80 ubuntu/nginx
      82a9ea1c84b16e24494f2d46741056110cf4d973044f5c91bd423f93bb46989a
      vagrant@vagrant:/$ sudo docker ps -a
      CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS
            NAMES
      82a9ea1c84b1   ubuntu/nginx   "/docker-entrypoint.…"   8 seconds ago   Up 7 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx-container-netology  
потом получаем доступ к командной оболочке:

      sudo docker exec -it nginx-container-netology /bin/bash
      root@82a9ea1c84b1:/#

Изменили страницу пример и проверили изменения:    
![](https://s551sas.storage.yandex.net/rdisk/1f3d9b6906aac9ba67a95885d8c00bf90be21424afacc75347897e0b9d54e49c/621fc663/-yg_cLuuhfuAgJu7cu40CmWAHxuJTPlnrJ-TN-FNQ3u35UJaGtiNbUSn-D4SNameC6HV_UQ9HGH1JI3EFftYcw==?uid=160010782&filename=%D1%81%D0%BA%D1%80%D0%B8%D0%BD%202%20%D0%B8%D0%B7%D0%BC%D0%B5%D0%BD%D0%B8%D0%BB%D0%B8%20%20%D0%B8%20%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%B8%D0%BB%D0%B8%20%D1%81%D1%82%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D1%83%20%20%E2%80%94%20%D0%BA%D0%BE%D0%BF%D0%B8%D1%8F.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=112417&hid=62d18d3d33597f4e64d4e3626e6f80d8&media_type=image&tknv=v2&etag=0355a7e2cad903d41cde16220f72d61b&rtoken=yzSdVZCfZXTn&force_default=yes&ycrid=na-c695bbc819a9858f4056c13d3d1d9f72-downloader3e&ts=5d94158e41ec0&s=934f1f8f77e2e53a308863a72459b77dc7c11045aa3ef19ef9f84ca603866841&pb=U2FsdGVkX1_UWU7XFRr88yaxh4jr0aaF9RPfPL9mAZnEsCMrCfONxk1-oXMjGEy09m38i4aL7nsbP5Okq8TK4Q647fQKBBgw81m-zuSkSgk)


Сохраним изменения
1) ищем нужный контейнер vagrant@vagrant:~$ sudo docker ps  

         
      vagrant@vagrant:~$ sudo docker ps
      CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                   NAMES
      82a9ea1c84b1   ubuntu/nginx   "/docker-entrypoint.…"   52 minutes ago   Up 52 minutes   0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx-container-netology

тут сохраняем контейнер в образ:

      vagrant@vagrant:~$ sudo docker commit -m "стартовая нетологии" -a "Евгений" 82a9ea1c84b1 vagrant/docker/obraz/obrazds
ответ:  
      
      sha256:486b5cc9132fbc03fba2dc94e2011d571a73f9ecf3eb9092e087b8af38997155

смотрим список образов, сохраненый образ стоит 1м в списке :  

      vagrant@vagrant:~$ sudo docker images
      REPOSITORY                     TAG               IMAGE ID       CREATED          SIZE
      vagrant/docker/obraz/obrazds   latest            486b5cc9132f   21 seconds ago   174MB
      ubuntu/nginx                   1.18-21.10_beta   a62da4d9278b   5 days ago       139MB
      ubuntu/nginx                   latest            a62da4d9278b   5 days ago       139MB
      hello-world                    latest            feb5d9fea6a5   5 months ago     13.3kB

теперь запустим созданный контейнер:  

      vagrant@vagrant:/$ sudo docker run -d --name nginx-netology-ds -p 8080:80 vagrant/docker/obraz/obrazds
      f542c1b563d0a016c0d9e0fd68ab272387f5f293a29c97c3a4dcab47046c66a2  
      vagrant@vagrant:/$ sudo docker ps
      CONTAINER ID   IMAGE                          COMMAND                  CREATED          STATUS          PORTS                                   NAMES
      f542c1b563d0   vagrant/docker/obraz/obrazds   "/docker-entrypoint.…"   42 seconds ago   Up 41 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx-netology-ds
  
и проверка :
![](https://s382vla.storage.yandex.net/rdisk/370591de1aad64823607297c5f1041ba5e6d629192cc7672e9ff7d37077892c1/621fc67f/-yg_cLuuhfuAgJu7cu40CgrZQ7V9QpSCFGw-JuJl_34nxlv36OpdTeQ61GTscS0agjJrg2rQCXAE3MXaydSixA==?uid=160010782&filename=%D1%81%D0%BA%D1%80%D0%B8%D0%BD%203%20.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=33774&hid=df3933dec248e27aa2719a28117fbeae&media_type=image&tknv=v2&etag=0f9532926a6bcdb7667cf0493366bbe5&rtoken=IePB7G34BrbE&force_default=yes&ycrid=na-5846f43f80701878141d4f59922d57a0-downloader3e&ts=5d9415a8f5dc0&s=01825c621dd428fe8ad9dc0ca7ee983ace00fff60aa9a076eab8fa1dc27f32e5&pb=U2FsdGVkX18aFeOTNUcAxfFX_TnNg0-kz6a9FORfG8GXEzp1mDHAEugnCdNQShObtHgrfXzMXg4AH3_WCQgK2NLjbFc3ntcYOecZ2GXJeh4)  
Ссылка на образ https://hub.docker.com/r/vaga991/netology  

## 2. Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"Детально опишите и обоснуйте свой выбор.

Сценарий:

 1) Высоконагруженное монолитное java веб-приложение;
Физический сервер, т.к. монолитное, селдовательно в микросерверах не реализуемо без изменения кода, а поскольку высоконагруженное то необходим физический доступ к ресурсами, без использования промежуточных "прокладок". 
 2) Nodejs веб-приложение;
Это веб приложение, для таких приложений достаточно контейнерной.
 3) Мобильное приложение c версиями для Android и iOS;
Виртаульная машина - приложение в докере не имеет GUI.
 4) Шина данных на базе Apache Kafka;
Зависит от передаваемых данных или контура (тест/продакшн), в продакшн и критично важных данных лучше Вируалка, для теста достаточно Контейнерной реализации, если потеря данных при потере контенйера не является критичной. 
 5) Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
сам Elasticsearvh лучше на виртуалку, отказоустойчивость решается на уровне кластера, кибану и логсташ можно вынести в докер контейнер, или так же на виртуалках. 
 6) Мониторинг-стек на базе Prometheus и Grafana;
сами системы не хранят как таковых данны, можно развернуть на Докере, в плюс это скорость развертывания, возможность масштабирования для различных задач:
 7) MongoDB, как основное хранилище данных для java-приложения;
Виртуальную машину, т.к. хранилище и  не сказано что высоконагруженное, а физический сервер будет дорог, Ну а хранение данных в контейнере это не надо.
 8) Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
Виртуалка - поскольку доступ может понадобиться разным пользователям, так же надо хранить данные.


## 3.
Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data;
Добавьте еще один файл в папку /data на хостовой машине;
Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.
 
Качаем образ: 

      docker pull centos 

но тут с запуском я тупанул и контейнер запускался и завершался сразу после завершения основного процесса, поэтому передаем ему параметры i и t, а d это фоновый режим:  

      sudo docker run -dit --name centos-ds3 -p 8080:80  centos

подключаемся:  

      sudo docker exec -it centos-ds3 /bin/bash

## Вот тут у меня возникло непонимание как делать: Как я понял надо сделать Один контейнет на базе centos второй на из debean подключить к ним одну и туже папку а потом создать файл из хостовой и из 1ого контейнера , а во втором проверить содержимое. Правильно понимаю???

## И вопрос еще: когда пытаюсь создать папку контейнере или посмотреть что там есть  то говорит неизвестная команда , например:

		[root@38a693c5171c /]# ls -la
		bash: $'\320\264\321\213ls': command not found

## Как я понял тут не хватает чегото в контейнере, в какую сторону мне копать чтоб я смог выполнить?   