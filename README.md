# Домашнее задание к занятию 6.2. SQL

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.
		
### Сделано.  
Находим этот образ с нужным нам по заданию PostgreSQL:  
https://hub.docker.com/_/postgres ~~(тут как ставить ну и сам образ)~~

Команды:  
    
скачиваеи образ с нужным тэгом (:12)

    vagrant@vagrant:/vagrant/dz62SQL$ docker pull postgres:12
Проверяем список образов

    vagrant@vagrant:/vagrant/dz62SQL$ docker images
    REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
    postgres      12        19789c9e8369   2 weeks ago    373MB
    hello-world   latest    feb5d9fea6a5   7 months ago   13.3kB
Создаем volume

    vagrant@vagrant:/vagrant/dz62SQL$ docker volume create voldate
    voldate
    vagrant@vagrant:/vagrant/dz62SQL$ docker volume create volbackup
    volbackup
Разворачиваем

    vagrant@vagrant:/vagrant/dz62SQL$ docker run --rm --name dz62sql -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v volbackup:/var/lib/postgresql/data -v voldate:/var/lib/postgresql postgres:12  
Потом находим id контейнера и заходим в контейнер 

    vagrant@vagrant:/var/lib$ sudo docker ps
    CONTAINER ID   IMAGE         COMMAND                  CREATED              STATUS              PORTS                                       NAMES
    871eda778038   postgres:12   "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   dz62sql
    vagrant@vagrant:/var/lib$ sudo docker exec -it 871eda778038 bash
Переключаемся на юзера postgres и проверяем версию PostgreSQL. 

    root@871eda778038:/# su - postgres
    postgres@871eda778038:~$ psql --version
    psql (PostgreSQL) 12.10 (Debian 12.10-1.pgdg110+1)
Заходим в БД и смотрим все определенные БД

    postgres@871eda778038:~$ psql
    postgres=# \list
                                     List of databases
       Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
    -----------+----------+----------+------------+------------+-----------------------
     postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
     template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
     template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
    (3 rows)

## Задача 2
В БД из задачи 1:

создайте пользователя test-admin-user и БД test_db  
создаем юзера test-admin-user и  test-simple-user:

    postgres=# CREATE ROLE "test-admin-user" SUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
    CREATE ROLE
    postgres=# CREATE ROLE "test-simple-user" NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
    CREATE ROLE
    postgres=# \du
                                           List of roles
        Role name     |                         Attributes                         | Member of
    ------------------+------------------------------------------------------------+-----------
     postgres         | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
     test-admin-user  | Superuser, No inheritance                                  | {}
     test-simple-user | No inheritance                                             | {}
    

Создаем БД  test_db:

    postgres=# create database test_db;
    CREATE DATABASE
    postgres=# \l
           List of databases
       Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
    -----------+----------+----------+------------+------------+-----------------------
     postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
     template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
     template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
     test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
    (4 rows)
в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)  
    
    postgres=# CREATE TABLE orders
    postgres-# (
    postgres(# id integer,
    postgres(# name text,
    postgres(# price integer,
    postgres(# PRIMARY KEY (id)
    postgres(# );
    CREATE TABLE

    postgres=# CREATE TABLE clients
    postgres-# (
    postgres(#  id integer PRIMARY KEY,
    postgres(#  lastname text,
    postgres(#  country text,
    postgres(#  booking integer,
    postgres(#  FOREIGN KEY (booking) REFERENCES orders (Id)
    postgres(# );
    CREATE TABLE
и смотрим список таблиц

    postgres=# SELECT table_name FROM information_schema.tables
    WHERE table_schema NOT IN ('information_schema','pg_catalog');
     table_name
    ------------
     orders
     clients
    (2 rows)

предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

    postgres=# GRANT SELECT ON TABLE public.clients TO "test-simple-user";
    GRANT
    postgres=# GRANT INSERT ON TABLE public.clients TO "test-simple-user";
    GRANT
    postgres=# GRANT UPDATE ON TABLE public.clients TO "test-simple-user";
    GRANT
    postgres=# GRANT DELETE ON TABLE public.clients TO "test-simple-user";
    GRANT
    postgres=# GRANT SELECT ON TABLE public.orders TO "test-simple-user";
    GRANT
    postgres=# GRANT INSERT ON TABLE public.orders TO "test-simple-user";
    GRANT
    postgres=# GRANT UPDATE ON TABLE public.orders TO "test-simple-user";
    GRANT
    postgres=# GRANT DELETE ON TABLE public.orders TO "test-simple-user";
    GRANT
Проверяем права юзеров на БД:

    postgres=#  SELECT * FROM information_schema.table_privileges where grantee in ('test-admin-user','test-simple-user');
     grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy
    ----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
     postgres | test-simple-user | postgres      | public       | clients    | INSERT         | NO           | NO
     postgres | test-simple-user | postgres      | public       | clients    | SELECT         | NO           | YES
     postgres | test-simple-user | postgres      | public       | clients    | UPDATE         | NO           | NO
     postgres | test-simple-user | postgres      | public       | clients    | DELETE         | NO           | NO
     postgres | test-simple-user | postgres      | public       | orders     | INSERT         | NO           | NO
     postgres | test-simple-user | postgres      | public       | orders     | SELECT         | NO           | YES
     postgres | test-simple-user | postgres      | public       | orders     | UPDATE         | NO           | NO
     postgres | test-simple-user | postgres      | public       | orders     | DELETE         | NO           | NO
    (8 rows)

## Задача 3
Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

        Таблица orders  
    Наименование 	цена  
    Шоколад 	10  
    Принтер 	3000  
    Книга 	500  
    Монитор 	7000  
    Гитара 	4000  

        Таблица clients  
    ФИО 	                Страна проживания  
    Иванов Иван Иванович 	USA  
    Петров Петр Петрович 	Canada  
    Иоганн Себастьян Бах 	Japan  
    Ронни Джеймс Дио 	Russia  
    Ritchie Blackmore 	Russia  

/

    Используя SQL синтаксис:  
    вычислите количество записей для каждой таблицы  
    приведите в ответе:  
        запросы  
        результаты их выполнения.  
Заполняем: 

    postgres=# insert into orders VALUES (1, 'Chocolate', 10), (2, 'Printer', 3000), (3, 'Book', 500), (4, 'Monitor', 7000), (5, 'Guitar' , 4000);
    INSERT 0 5
    postgres=# insert into clients VALUES (1, 'Ivanov Ivan Ivanovich', 'USA'), (2, 'Petrov Petr Petrovich', 'Canada'), (3, 'Johann Sebastian Bach', 'Japan'), (4, ' Ronnie James Dio', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
     (*) froINSERT 0 5
Проверяем количество записей 

    postgres=# select count(*) from clients;
     count
    -------
         5
    (1 row)
    
    postgres=# select count (*) from orders;
     count
    -------
         5
    (1 row)


## Задача 4
Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

        ФИО 	                Заказ  
        Иванов Иван Иванович 	Книга  
        Петров Петр Петрович 	Монитор  
        Иоганн Себастьян Бах 	Гитара  

Приведите SQL-запросы для выполнения данных операций.

    postgres=# update  clients set booking = 3 where id = 1;
    UPDATE 1
    postgres=# update  clients set booking = 4 where id = 2;
    ate  UPDATE 1
    postgres=# update  clients set booking = 5 where id = 3;
    UPDATE 1
Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
    
    postgres=# select * from clients as c where  exists (select id from orders as o where c.booking = o.id) ;
     id |       lastname        | country | booking
    ----+-----------------------+---------+---------
      1 | Ivanov Ivan Ivanovich | USA     |       3
      2 | Petrov Petr Petrovich | Canada  |       4
      3 | Johann Sebastian Bach | Japan   |       5
    (3 rows)
Подсказк - используйте директиву UPDATE.

## Задача 5
Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).
Приведите получившийся результат и объясните что значат полученные значения.

Вариант 1

    postgres=# explain select * from clients as c where  exists (select id from orders as o where c.booking = o.id) ;
                                   QUERY PLAN
    ------------------------------------------------------------------------
     Hash Join  (cost=37.00..57.24 rows=810 width=72)
       Hash Cond: (c.booking = o.id)
       ->  Seq Scan on clients c  (cost=0.00..18.10 rows=810 width=72)
       ->  Hash  (cost=22.00..22.00 rows=1200 width=4)
             ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=4)
    (5 rows)
Вариант 2  

    postgres=# explain select * from clients where booking is not null;
                            QUERY PLAN
    -----------------------------------------------------------
     Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
       Filter: (booking IS NOT NULL)
    (2 rows)
Команда explain не выполняет команду к которой применена , а выводит информацию о этапах осуществления поиска по БД, это называется планом. В нем содержится время выполнения для всего плана и его частей(узлов??), если план сложный.
В случае сложного плана , он представляет собой древовидную структуру где указан метод применяемый на данном этапе и затраты на его исполнение. 
Числа, перечисленные в скобках (слева направо), имеют следующий смысл:  
    Приблизительная стоимость запуска. Это время, которое проходит, прежде чем начнётся этап вывода данных, например для сортирующего узла это время сортировки.  
    Приблизительная общая стоимость. Она вычисляется в предположении, что узел плана выполняется до конца, то есть возвращает все доступные строки.  
    Ожидаемое число строк, которое должен вывести этот узел плана. При этом так же предполагается, что узел выполняется до конца.  
    Ожидаемый средний размер строк, выводимых этим узлом плана (в байтах).  

## Задача 6
Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.

запуск 2ого контейнера

    vagrant@vagrant:/$ docker run --rm --name dz62sql2 -e POSTGRES_PASSWORD=postgres -ti -p 5433:5433 -v volbackup:/var/lib/postgresql/data -v voldate:/var/lib/postgres
    ql postgres:12
    vagrant@vagrant:~$ sudo docker ps
    CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS                                                 NAMES
    d73be7bec0f1   postgres:12   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   5432/tcp, 0.0.0.0:5433->5433/tcp, :::5433->5433/tcp   dz62sql2
    871eda778038   postgres:12   "docker-entrypoint.s…"   2 days ago      Up 2 days      0.0.0.0:5432->5432/tcp, :::5432->5432/tcp             dz62sql

делаем бэкап и востанавливаем 

    vagrant@vagrant:/$ sudo  docker exec -t dz62sql pg_dump -U postgres test_db -f /var/lib/postgresql/data/dump_test.sql
    vagrant@vagrant:/$ sudo docker exec -i dz62sql psql -U postgres -d test_db -f /var/lib/postgresql/data/dump_test.sql
    SET
    SET
    SET
    SET
    SET
     set_config
    ------------
    
    (1 row)
    
    SET
    SET
    SET
    SET
Подключаемся к 2му контейнеру и смотрим

    vagrant@vagrant:~$ sudo docker ps
    CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS                                                 NAMES
    d73be7bec0f1   postgres:12   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   5432/tcp, 0.0.0.0:5433->5433/tcp, :::5433->5433/tcp   dz62sql2
    871eda778038   postgres:12   "docker-entrypoint.s…"   2 days ago      Up 2 days      0.0.0.0:5432->5432/tcp, :::5432->5432/tcp             dz62sql

    vagrant@vagrant:~$ sudo docker exec -it d73be7bec0f1 bash
    root@d73be7bec0f1:/# su - postgres
    postgres@d73be7bec0f1:~$ psql
    psql (12.10 (Debian 12.10-1.pgdg110+1))
    Type "help" for help.
    
    postgres=# \l
                                     List of databases
       Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
    -----------+----------+----------+------------+------------+-----------------------
     postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
     template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
     template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
     test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
    (4 rows)
Для достоверности повторим один из запросов и сравним результаты 

    postgres=#  select * from clients as c where  exists (select id from orders as o where c.booking = o.id) ;
     id |       lastname        | country | booking
    ----+-----------------------+---------+---------
      1 | Ivanov Ivan Ivanovich | USA     |       3
      2 | Petrov Petr Petrovich | Canada  |       4
      3 | Johann Sebastian Bach | Japan   |       5
    (3 rows)
о все на месте.