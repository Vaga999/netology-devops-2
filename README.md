# Домашнее задание к занятию 6.6. Troubleshooting

Задача 1

Перед выполнением задания ознакомьтесь с документацией по администрированию MongoDB.

Пользователь (разработчик) написал в канал поддержки, что у него уже 3 минуты происходит CRUD операция в MongoDB и её нужно прервать.

Вы как инженер поддержки решили произвести данную операцию:

напишите список операций, которые вы будете производить для остановки запроса пользователя


        Необходимо найти opid операции:
        
        db.currentOp({ "active" : true, "secs_running" : { "$gt" : 180 }})
        
        {
            "inprog" : [
                {
                    //...
                    "opid" : 1234567,
                    "secs_running" : NumberLong(123)
                    //...
                }
            ]
        }
        
        Завершить принудительно
        
        db.killOp(1234567)


предложите вариант решения проблемы с долгими (зависающими) запросами в MongoDB

        Использовать метод maxTimeMS() для установки предела исполнения по времени операций 
        Используя Database Profiler, отловить медленные операции. С помощью executionStats проанализировать. 
        Попробоватьоптимизировать: добавить/удалить индексы, настроить шардинг и т.д.

Задача 2

Перед выполнением задания познакомьтесь с документацией по Redis latency troobleshooting.

Вы запустили инстанс Redis для использования совместно с сервисом, который использует механизм TTL. Причем отношение количества записанных key-value значений к количеству истёкших значений есть величина постоянная и увеличивается пропорционально количеству реплик сервиса.

При масштабировании сервиса до N реплик вы увидели, что:

    сначала рост отношения записанных значений к истекшим
    Redis блокирует операции записи

Как вы думаете, в чем может быть проблема?

	Возможнo вся память занята истекшими ключами, но еще не удаленными. Redis заблокировался (ACTIVE_EXPIRE_CYCLE_LOOKUPS_PER_LOOP),
	чтобы вывести из DB удаленные ключи и снизить их количество менее 25%. Т.к. Redis - однопоточное приложение, то все операции блокируются,
	пока он не выполнит очистку. Имеет смысл подобрать значение hz в redis.conf
	
Задача 3

Вы подняли базу данных MySQL для использования в гис-системе. При росте количества записей, в таблицах базы, пользователи начали жаловаться на ошибки вида:

	InterfaceError: (InterfaceError) 2013: Lost connection to MySQL server during query u'SELECT..... '

Как вы думаете, почему это начало происходить и как локализовать проблему?  

	Основываясь на документации MySQL https://dev.mysql.com/doc/refman/8.0/en/error-lost-connection.html возможны три причины:
	1. Слишком объемные запросы (миллионы строк) не успевают передаться за отведеное время, рекомендуется увеличение параметра net_read_timeout
	2. Малое значение параметра connect_timeout, клиент не успевает установить соединение.
	3. Размер сообщения/запроса превышает размер буфера max_allowed_packet на сервере или max_allowed_packet на строне клиента.
	
Какие пути решения данной проблемы вы можете предложить?  

	1. Увеличить на сервере MySQL wait_timeout, max_allowed_packet, net_write_timeout и net_read_timeout
	2. В SQLAlchemy уменьшить pool_recycle, wait_timeout
	3. При исчезновении ошибки Lost connection to MySQL server during query возвращать по одному параметры в исходное состояние - для локализации проблемы.


Задача 4

Вы решили перевести гис-систему из задачи 3 на PostgreSQL, так как прочитали в документации, что эта СУБД работает с большим объемом данных лучше, чем MySQL.

После запуска пользователи начали жаловаться, что СУБД время от времени становится недоступной. В dmesg вы видите, что:

	postmaster invoked oom-killer

Как вы думаете, что происходит?

	Postgres недостаточно памяти.
	Когда у сервера/процесса заканчивается память, Linux предлагает два пути решения: обрушить систему или завершить процесс, который съедает память.
	Out-Of-Memory Killer — это процесс, который завершает приложение, чтобы спасти ядро от сбоя.
    ~~ Читалось тут: https://habr.com/ru/company/southbridge/blog/464245/ ~~

Как бы вы решили данную проблему?

	1. По возможности добавить ресурсов (RAM), провести ревизию и отключить/перенести ненужные приложения.
	2. Произвести настройку параметров, затрагивающих память в Postgres:
		max_connections
		shared_buffer
		work_mem
		effective_cache_size
		maintenance_work_mem