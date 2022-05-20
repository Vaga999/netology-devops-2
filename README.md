# Домашнее задание к занятию 6.3. MySQL

Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.
Образ: https://hub.docker.com/_/mysql  
Качаем:  

    vagrant@vagrant:/vagrant/6_3_MySQL$ docker pull mysql:8
    vagrant@vagrant:/vagrant/6_3_MySQL$ docker images
    REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
    mysql         8         76152be68449   4 days ago     524MB
Делаем volume с именем volume_dz  

    vagrant@vagrant:/vagrant/6_3_MySQL$ docker volume create --name volume_dz
    volume_dz
    vagrant@vagrant:/vagrant/6_3_MySQL$ docker volume ls
    DRIVER    VOLUME NAME
    local     volume_dz
Запускаем контейнер:
    
    vagrant@vagrant:/vagrant/6_3_MySQL$ docker run -v /volume_dz --name mysqldz -d -e MYSQL_ROOT_PASSWORD=mysql mysql
    Unable to find image 'mysql:latest' locally
    latest: Pulling from library/mysql
    Digest: sha256:a0805d37d4d298bd61e0dfa61f0ddf6f4680b453fa25d7aad420485a62417eab
    Status: Downloaded newer image for mysql:latest
    093f2212d524f3c52d8aacc31126c202c94405430ec045c8d0da6fe36279b469
Копируем с хоста на volume_dz:  
    
    docker cp /vagrant/6_3_MySQL/test_data/test_dump.sql 878f636a0266:/volume_dz
входим в контейнер 

    vagrant@vagrant:/vagrant/6_3_MySQL$ docker exec -it mysql1 bash
из контейнера проверяем

    root@878f636a0266:/# cd /volume_dz
    root@878f636a0266:/volume_dz# ls -la
    total 12
    drwxr-xr-x 2 root root 4096 May 16 14:40 .
    drwxr-xr-x 1 root root 4096 May 16 14:40 ..
    -rwxrwxrwx 1 1000 1000 2125 Mar 25 10:33 test_dump.sql
    root@878f636a0266:/volume_dz#
~~для себя   
docker cp адресФайлаКоторыйКопируем [ID или Имя контейнера]:адресКуда~~

Изучите бэкап БД и восстановитесь из него.

    root@878f636a0266:/# mysql -uroot -pmysql test_db < test_dump.sql
    bash: test_dump.sql: No such file or directory
тут оно ругалось на отсутствие базы, создаем базу и далее;

    root@878f636a0266:/# mysql -uroot -pmysql
    mysql: [Warning] Using a password on the command line interface can be insecure.
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 13
    Server version: 8.0.29 MySQL Community Server - GPL
    
    Copyright (c) 2000, 2022, Oracle and/or its affiliates.
    .....
    .....
    mysql> CREATE DATABASE test_db;
    Query OK, 1 row affected (0.00 sec)
    mysql> use test_db;
    Reading table information for completion of table and column names
    You can turn off this feature to get a quicker startup with -A
    Database changed
       

Перейдите в управляющую консоль mysql внутри контейнера:
    
    root@878f636a0266:/# mysql -uroot -pmysql
    mysql: [Warning] Using a password on the command line interface can be insecure.
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 16
    Server version: 8.0.29 MySQL Community Server - GPL
    
    Copyright (c) 2000, 2022, Oracle and/or its affiliates.
    
    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.
    
    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

Используя команду \h получите список управляющих команд.

    mysql> \h
    
    For information about MySQL products and services, visit:
       http://www.mysql.com/
    For developer information, including the MySQL Reference Manual, visit:
       http://dev.mysql.com/
    To buy MySQL Enterprise support, training, or other products, visit:
       https://shop.mysql.com/
    
    List of all MySQL commands:
    Note that all text commands must be first on line and end with ';'
    ?         (\?) Synonym for `help'.
    clear     (\c) Clear the current input statement.
    connect   (\r) Reconnect to the server. Optional arguments are db and host.
    delimiter (\d) Set statement delimiter.
    edit      (\e) Edit command with $EDITOR.
    ego       (\G) Send command to mysql server, display result vertically.
    exit      (\q) Exit mysql. Same as quit.
    go        (\g) Send command to mysql server.
    help      (\h) Display this help.
    nopager   (\n) Disable pager, print to stdout.
    notee     (\t) Don't write into outfile.
    pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
    print     (\p) Print current command.
    prompt    (\R) Change your mysql prompt.
    quit      (\q) Quit mysql.
    rehash    (\#) Rebuild completion hash.
    source    (\.) Execute an SQL script file. Takes a file name as an argument.
    status    (\s) Get status information from the server.
    system    (\!) Execute a system shell command.
    tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
    use       (\u) Use another database. Takes database name as argument.
    charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
    warnings  (\W) Show warnings after every statement.
    nowarning (\w) Don't show warnings after every statement.
    resetconnection(\x) Clean session context.
    query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.
    ssl_session_data_print Serializes the current SSL session data to stdout or file
    
    For server side help, type 'help contents'
Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.

    mysql> \s
    --------------
    mysql  Ver 8.0.29 for Linux on x86_64 (MySQL Community Server - GPL)
    
    Connection id:          8
    Current database:
    Current user:           root@localhost
    SSL:                    Not in use
    Current pager:          stdout
    Using outfile:          ''
    Using delimiter:        ;
    Server version:         8.0.29 MySQL Community Server - GPL
    Protocol version:       10
    Connection:             Localhost via UNIX socket
    Server characterset:    utf8mb4
    Db     characterset:    utf8mb4
    Client characterset:    latin1
    Conn.  characterset:    latin1
    UNIX socket:            /var/run/mysqld/mysqld.sock
    Binary data as:         Hexadecimal
    Uptime:                 26 min 22 sec
    
    Threads: 2  Questions: 5  Slow queries: 0  Opens: 117  Flush tables: 3  Open tables: 36  Queries per second avg: 0.003  
    --------------


Подключитесь к восстановленной БД и получите список таблиц из этой БД.

    mysql> show tables;
    +-------------------+
    | Tables_in_test_db |
    +-------------------+
    | orders            |
    +-------------------+
    1 row in set (0.00 sec)

Приведите в ответе количество записей с price > 300.

    mysql> select count(*) FROM orders where price > 300;
    +----------+
    | count(*) |
    +----------+
    |        1 |
    +----------+
    1 row in set (0.00 sec)

В следующих заданиях мы будем продолжать работу с данным контейнером.
Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:

    плагин авторизации mysql_native_password
    срок истечения пароля - 180 дней
    количество попыток авторизации - 3
    максимальное количество запросов в час - 100
    аттрибуты пользователя:
        Фамилия "Pretty"
        Имя "James"
Предоставьте привелегии пользователю test на операции SELECT базы test_db.
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю test и приведите в ответе к задаче.
    
    mysql> CREATE USER 'test'@'localhost' IDENTIFIED BY 'test-pass';
    Query OK, 0 rows affected (0.01 sec)
    
    mysql> ALTER USER 'test'@'localhost' ATTRIBUTE '{"fname":"James", "lname":"Pretty"}';
    Query OK, 0 rows affected (0.00 sec)
    
    mysql> SELECT CURRENT_USER();
    +----------------+
    | CURRENT_USER() |
    +----------------+
    | root@localhost |
    +----------------+
    1 row in set (0.00 sec)
    
    mysql> ALTER USER 'test'@'localhost'
        ->  IDENTIFIED BY 'test-pass'
        -> WITH
        -> MAX_QUERIES_PER_HOUR 100
        -> PASSWORD EXPIRE INTERVAL 180 DAY
        -> FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2;
    Query OK, 0 rows affected (0.00 sec)
    
    mysql> GRANT Select ON test_db.orders TO 'test'@'localhost';
    Query OK, 0 rows affected, 1 warning (0.00 sec)
    
    mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
    +------+-----------+---------------------------------------+
    | USER | HOST      | ATTRIBUTE                             |
    +------+-----------+---------------------------------------+
    | test | localhost | {"fname": "James", "lname": "Pretty"} |
    +------+-----------+---------------------------------------+
    1 row in set (0.00 sec)

Задача 3

Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES;.Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.
Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:

    mysql> SET profiling = 1;
    Query OK, 0 rows affected, 1 warning (0.00 sec)

    mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
    +------+-----------+---------------------------------------+
    | USER | HOST      | ATTRIBUTE                             |
    +------+-----------+---------------------------------------+
    | test | localhost | {"fname": "James", "lname": "Pretty"} |
    +------+-----------+---------------------------------------+
    1 row in set (0.00 sec)
    
    mysql>  SHOW PROFILES;
    +----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    | Query_ID | Duration   | Query
                                                                             |
    +----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    |        1 | 0.04656925 | ALTER TABLE orders ENGINE = MyISAM
                                                                             |
    |        2 | 0.07649200 | ALTER TABLE orders ENGINE = InnoDB
                                                                             |
    |        3 | 0.00580350 | SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
    |        4 | 0.00052550 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test'
                                                                             |
    |        5 | 0.00010975 | SET profiling = 1
                                                                             |
    |        6 | 0.00036700 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test'
                                                                             |
    |        7 | 0.00134425 | SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
    |        8 | 0.00007775 | +------------+--------+------------+------------+-------------+--------------+
                                                                             |
    |        9 | 0.01093950 | SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
    |       10 | 0.00993625 | ALTER TABLE orders ENGINE = MyISAM
                                                                             |
    |       11 | 0.00052200 | SET profiling = 1
                                                                             |
    |       12 | 0.00039700 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test'
                                                                             |
    +----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    12 rows in set, 1 warning (0.00 sec)
    mysql> SET profiling = 1;
    Query OK, 0 rows affected, 1 warning (0.00 sec)

    mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
    +------+-----------+---------------------------------------+
    | USER | HOST      | ATTRIBUTE                             |
    +------+-----------+---------------------------------------+
    | test | localhost | {"fname": "James", "lname": "Pretty"} |
    +------+-----------+---------------------------------------+
    1 row in set (0.00 sec)

    mysql> SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc;
    +------------+--------+------------+------------+-------------+--------------+
    | TABLE_NAME | ENGINE | ROW_FORMAT | TABLE_ROWS | DATA_LENGTH | INDEX_LENGTH |
    +------------+--------+------------+------------+-------------+--------------+
    | orders     | MyISAM | Dynamic    |          5 |       16384 |            0 |
    +------------+--------+------------+------------+-------------+--------------+
    1 row in set (0.00 sec)
тут используется MyISAM 

Сменим на InnoDB

    mysql> SHOW PROFILES;
    +----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    | Query_ID | Duration   | Query                                                                                                                                                                                |
    +----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    |        2 | 0.07649200 | ALTER TABLE orders ENGINE = InnoDB                                                                                                                                                   |
    |        3 | 0.00580350 | SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
    |        4 | 0.00052550 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test'                                                                                                                   |
    |        5 | 0.00010975 | SET profiling = 1                                                                                                                                                                    |
    |        6 | 0.00036700 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test'                                                                                                                   |
    |        7 | 0.00134425 | SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
    |        8 | 0.00007775 | +------------+--------+------------+------------+-------------+--------------+                                                                                                       |
    |        9 | 0.01093950 | SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
    |       10 | 0.00993625 | ALTER TABLE orders ENGINE = MyISAM                                                                                                                                                   |
    |       11 | 0.00052200 | SET profiling = 1                                                                                                                                                                    |
    |       12 | 0.00039700 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test'                                                                                                                   |
    |       13 | 0.00404725 | SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
    |       14 | 0.01243150 | ALTER TABLE orders ENGINE = MyISAM                                                                                                                                                   |
    |       15 | 0.10683675 | ALTER TABLE orders ENGINE = InnoDB                                                                                                                                                   |
    |       16 | 0.00027275 | InnoDB                                                                                                                                                                               |
    +----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    15 rows in set, 1 warning (0.00 sec)
Время переключения
    
    mysql> SET profiling = 1;
    Query OK, 0 rows affected, 1 warning (0.00 sec)
    
    mysql>  ALTER TABLE orders ENGINE = MyISAM;
    Query OK, 5 rows affected (0.09 sec)
    Records: 5  Duplicates: 0  Warnings: 0
    
    mysql>  ALTER TABLE orders ENGINE = MyISAM;
    Query OK, 5 rows affected (0.01 sec)
    Records: 5  Duplicates: 0  Warnings: 0
    
    mysql> ALTER TABLE orders ENGINE = InnoDB;
    Query OK, 5 rows affected (0.09 sec)
    Records: 5  Duplicates: 0  Warnings: 0
    
    mysql> SHOW PROFILES;
    +----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    | Query_ID | Duration   | Query
                                                                             |
    +----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    |        6 | 0.00036700 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test'
    ......
    пропустим
    ......
    |       17 | 0.00008850 | SET profiling = 1
                                                                             |
    |       18 | 0.01087100 | ALTER TABLE orders ENGINE = MyISAM
                                                                             |
    |       19 | 0.08796575 | ALTER TABLE orders ENGINE = InnoDB
                                                                             |
    +----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    15 rows in set, 1 warning (0.00 sec)
Задача 4

Изучите файл my.cnf в директории /etc/mysql.
    
    root@878f636a0266:/volume_dz# cat /etc/mysql/my.cnf
    # Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
    #
    # This program is free software; you can redistribute it and/or modify
    # it under the terms of the GNU General Public License as published by
    # the Free Software Foundation; version 2 of the License.
    #
    # This program is distributed in the hope that it will be useful,
    # but WITHOUT ANY WARRANTY; without even the implied warranty of
    # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    # GNU General Public License for more details.
    #
    # You should have received a copy of the GNU General Public License
    # along with this program; if not, write to the Free Software
    # Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
    
    #
    # The MySQL  Server configuration file.
    #
    # For explanations see
    # http://dev.mysql.com/doc/mysql/en/server-system-variables.html
    
    [mysqld]
    pid-file        = /var/run/mysqld/mysqld.pid
    socket          = /var/run/mysqld/mysqld.sock
    datadir         = /var/lib/mysql
    secure-file-priv= NULL
    
    # Custom config should go here
    !includedir /etc/mysql/conf.d/
Измените его согласно ТЗ (движок InnoDB) приведите в ответе измененный файл my.cnf.:
можно добавить это   

    [mysqld]
    pid-file        = /var/run/mysqld/mysqld.pid
    socket          = /var/run/mysqld/mysqld.sock
    datadir         = /var/lib/mysql
    secure-file-priv= NULL
    
    # Custom config should go here
    !includedir /etc/mysql/conf.d/
    #Скорость IO важнее сохранности данных
    # 0 - скорость
    # 1 - сохранность
    # 2 - универсальный параметр
    innodb_flush_log_at_trx_commit = 0
    
    #Set compression
    # Barracuda - формат файла с сжатием увеличивает нагрузку на процессор
    innodb_file_format=Barracuda
    
    #Размер буфера с незакомиченными транзакциями 1 Мб
    innodb_log_buffer_size  = 1M
    
    #Буфер кеширования 30% от ОЗУ
    key_buffer_size = 330М
    
    # Размер файла логов операций 100 Мб
    max_binlog_size = 100M

