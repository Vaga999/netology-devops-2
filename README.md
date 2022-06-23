# Домашнее задание к занятию 6.5. Elasticsearch

Задача 1

<details>
    <summary>Задание</summary>
	
	В этом задании вы потренируетесь в:
	
		установке elasticsearch
		первоначальном конфигурировании elastcisearch
		запуске elasticsearch в docker
	
	Используя докер образ centos:7 как базовый и документацию по установке и запуску Elastcisearch:
	
		составьте Dockerfile-манифест для elasticsearch
		соберите docker-образ и сделайте push в ваш docker.io репозиторий
		запустите контейнер из получившегося образа и выполните запрос пути / c хост-машины
	
	Требования к elasticsearch.yml:
	
		данные path должны сохраняться в /var/lib
		имя ноды должно быть netology_test
	
	В ответе приведите:
	
		текст Dockerfile манифеста
		ссылку на образ в репозитории dockerhub
		ответ elasticsearch на запрос пути / в json виде
	
	Подсказки:
	
		возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
		при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
		при некоторых проблемах вам поможет docker директива ulimit
		elasticsearch в логах обычно описывает проблему и пути ее решения
	
	Далее мы будем работать с данным экземпляром elasticsearch.
</details> 
### Сделано  

В ответе приведите текст Dockerfile манифеста  
<details>
    <summary>Dockerfile</summary>

		FROM centos:7

		EXPOSE 9200 9300

		USER 0
		RUN mkdir /var/lib/logs
		RUN export ES_HOME="/var/lib/elasticsearch" && \
			yum -y install wget && \
			wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.0-linux-x86_64.tar.gz && \
			wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.0-linux-x86_64.tar.gz.sha512 && \
			sha512sum -c elasticsearch-7.17.0-linux-x86_64.tar.gz.sha512 && \
			tar -xzf elasticsearch-7.17.0-linux-x86_64.tar.gz && \
			rm -f elasticsearch-7.17.0-linux-x86_64.tar.gz* && \
			mv elasticsearch-7.17.0 ${ES_HOME} && \
			useradd -m -u 1000 elasticsearch && \
			chown elasticsearch:elasticsearch -R ${ES_HOME} && \
			yum -y remove wget && \
			yum clean all


		COPY --chown=elasticsearch:elasticsearch config/* /var/lib/elasticsearch/config/
			
		USER 1000

		ENV ES_HOME="/var/lib/elasticsearch" \
			ES_PATH_CONF="/var/lib/elasticsearch/config"
		WORKDIR ${ES_HOME}

		CMD ["sh", "-c", "${ES_HOME}/bin/elasticsearch"]
</details>

ссылку на образ в репозитории dockerhub  

		docker pull vaga991/vaga991
		
		
ответ elasticsearch на запрос пути / в json виде  

		vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X GET 'http://localhost:9200/'
		{
		  "name" : "netology_test",
		  "cluster_name" : "elasticsearch",
		  "cluster_uuid" : "YFU01ufuRBCBdHB_1WyctQ",
		  "version" : {
			"number" : "7.17.0",
			"build_flavor" : "default",
			"build_type" : "tar",
			"build_hash" : "bee86328705acaa9a6daede7140defd4d9ec56bd",
			"build_date" : "2022-01-28T08:36:04.875279988Z",
			"build_snapshot" : false,
			"lucene_version" : "8.11.1",
			"minimum_wire_compatibility_version" : "6.8.0",
			"minimum_index_compatibility_version" : "6.0.0-beta1"
		  },
		  "tagline" : "You Know, for Search"
		  
Задача 2

В этом задании вы научитесь:

    создавать и удалять индексы
    изучать состояние кластера
    обосновывать причину деградации доступности данных

Ознакомтесь с документацией и добавьте в elasticsearch 3 индекса, в соответствии со таблицей:

	Имя 	Количество реплик 	Количество шард  
	ind-1 		0 				1  
	ind-2 		1 				2  
	ind-3 		2 				4  

команды:  

	vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X PUT localhost:9200/ind-1 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
	
	vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X PUT localhost:9200/ind-2 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 2,  "number_of_replicas": 1 }}'
	
	vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X PUT localhost:9200/ind-3 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 4,  "number_of_replicas": 2 }}'
	
	


Получите список индексов и их статусов, используя API и приведите в ответе на задание.

	vagrant@vagrant:/vagrant/dz6_5/docker$  curl -X GET 'http://localhost:9200/_cat/indices?v'
	health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
	green  open   ind-1 VABOGeIeRbicR4Z6J4tFaQ   1   0          0            0       226b           226b
	yellow open   ind-3 yAB1UXk0RG-As_aiC5Kfbw   4   2          0            0       904b           904b
	yellow open   ind-2 ZFFjvflVSZWsviKmMLoZDA   2   1          0            0       452b           452b


Получите состояние кластера elasticsearch, используя API.



	vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X GET "localhost:9200/_cluster/health?pretty"
	{
	  "cluster_name" : "elasticsearch",
	  "status" : "yellow",
	  "timed_out" : false,
	  "number_of_nodes" : 1,
	  "number_of_data_nodes" : 1,
	  "active_primary_shards" : 9,
	  "active_shards" : 9,
	  "relocating_shards" : 0,
	  "initializing_shards" : 0,
	  "unassigned_shards" : 10,
	  "delayed_unassigned_shards" : 0,
	  "number_of_pending_tasks" : 0,
	  "number_of_in_flight_fetch" : 0,
	  "task_max_waiting_in_queue_millis" : 0,
	  "active_shards_percent_as_number" : 47.368421052631575

<details>
	<summary>состояние кластера elasticsearch по индексам</summary> 

	  vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty'
	{
	  "cluster_name" : "elasticsearch",
	  "status" : "green",
	  "timed_out" : false,
	  "number_of_nodes" : 1,
	  "number_of_data_nodes" : 1,
	  "active_primary_shards" : 1,
	  "active_shards" : 1,
	  "relocating_shards" : 0,
	  "initializing_shards" : 0,
	  "unassigned_shards" : 0,
	  "delayed_unassigned_shards" : 0,
	  "number_of_pending_tasks" : 0,
	  "number_of_in_flight_fetch" : 0,
	  "task_max_waiting_in_queue_millis" : 0,
	  "active_shards_percent_as_number" : 100.0
	}
	vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X GET 'http://localhost:9200/_cluster/health/ind-2?pretty'
	{
	  "cluster_name" : "elasticsearch",
	  "status" : "yellow",
	  "timed_out" : false,
	  "number_of_nodes" : 1,
	  "number_of_data_nodes" : 1,
	  "active_primary_shards" : 2,
	  "active_shards" : 2,
	  "relocating_shards" : 0,
	  "initializing_shards" : 0,
	  "unassigned_shards" : 2,
	  "delayed_unassigned_shards" : 0,
	  "number_of_pending_tasks" : 0,
	  "number_of_in_flight_fetch" : 0,
	  "task_max_waiting_in_queue_millis" : 0,
	  "active_shards_percent_as_number" : 47.368421052631575
	}
	vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X GET 'http://localhost:9200/_cluster/health/ind-3?pretty'
	{
	  "cluster_name" : "elasticsearch",
	  "status" : "yellow",
	  "timed_out" : false,
	  "number_of_nodes" : 1,
	  "number_of_data_nodes" : 1,
	  "active_primary_shards" : 4,
	  "active_shards" : 4,
	  "relocating_shards" : 0,
	  "initializing_shards" : 0,
	  "unassigned_shards" : 8,
	  "delayed_unassigned_shards" : 0,
	  "number_of_pending_tasks" : 0,
	  "number_of_in_flight_fetch" : 0,
	  "task_max_waiting_in_queue_millis" : 0,
	  "active_shards_percent_as_number" : 47.368421052631575
</details>

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

	Первичный шард и реплика не могут находиться на одном узле, если копия не назначена.  
	Таким образом, один узел не может размещать копии.  

Удалите все индексы.

	vagrant@vagrant:~$ curl -X DELETE 'http://localhost:9200/_all'
	{"acknowledged":true} 

Важно  
При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард, иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

Задача 3

В данном задании вы научитесь:

    создавать бэкапы данных
    восстанавливать индексы из бэкапов

Создайте директорию {путь до корневой директории с elasticsearch в образе}/snapshots.

	vagrant@vagrant:~$ sudo docker exec -u root -it elastic bash
	[root@fe992d3ed4cc elasticsearch]# mkdir $ES_HOME/snapshots
	
Используя API зарегистрируйте данную директорию как snapshot repository c именем netology_backup.

	[root@fe992d3ed4cc elasticsearch]#  echo path.repo: [ "/var/lib/elasticsearch/snapshots" ] >> "$ES_HOME/config/elasticsearch.yml"
	[root@fe992d3ed4cc elasticsearch]# chown elasticsearch:elasticsearch /var/lib/elasticsearch/snapshots

Приведите в ответе запрос API и результат вызова API для создания репозитория.

	vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d'
	> {
	>   "settings": {
	>     "number_of_shards": 1,
	>     "number_of_replicas": 0
	>   }
	> }
	> '
	{
	  "acknowledged" : true,
	  "shards_acknowledged" : true,
	  "index" : "test"
	}										

Создайте индекс test с 0 реплик и 1 шардом и приведите в ответе список индексов.

	vagrant@vagrant:~$ curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d'
	> {
	>   "settings": {
	>     "number_of_shards": 1,
	>     "number_of_replicas": 0
	>   }
	> }
	> '
	{
	  "acknowledged" : true,
	  "shards_acknowledged" : true,
	  "index" : "test"
	}
Список индексов

	vagrant@vagrant:/vagrant/dz6_5/docker$ curl 'localhost:9200/_cat/indices?v'
	health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
	green  open   test  p4sOG07gS3SD-7tzuZG9tQ   1   0          0            0       226b           226b

Создайте snapshot состояния кластера elasticsearch.

	vagrant@vagrant:~$ curl -X PUT "localhost:9200/_snapshot/netology_backup/snapshot_new?wait_for_completion=true&pretty"
	{
	  "snapshot" : {
		"snapshot" : "snapshot_1",
		"uuid" : "5OLxbdyAQn-yLKbsh_JrCg",
		"repository" : "netology_backup",
		"version_id" : 7170099,
		"version" : "7.17.0",
		"indices" : [
		  ".ds-.logs-deprecation.elasticsearch-default-2022.06.19-000001",
		  "test",
		  ".ds-ilm-history-5-2022.06.19-000001"
		],
		"data_streams" : [
		  "ilm-history-5",
		  ".logs-deprecation.elasticsearch-default"
		],
		"include_global_state" : true,
		"state" : "SUCCESS",
		"start_time" : "2022-06-19T03:18:32.340Z",
		"start_time_in_millis" : 1655608712340,
		"end_time" : "2022-06-19T03:18:32.791Z",
		"end_time_in_millis" : 1655608712791,
		"duration_in_millis" : 451,
		"failures" : [ ],
		"shards" : {
		  "total" : 3,
		  "failed" : 0,
		  "successful" : 3
		},
		"feature_states" : [ ]
	  }
	}

Приведите в ответе список файлов в директории со snapshotами.

	vagrant@vagrant:/vagrant/dz6_5/docker$ docker exec -it elastic_dz6 ls -l /var/lib/elasticsearch/snapshots/
	total 28
	-rw-r--r-- 1 elasticsearch elasticsearch 1165 Jun 19 03:18 index-0
	-rw-r--r-- 1 elasticsearch elasticsearch    8 Jun 19 03:18 index.latest
	drwxr-xr-x 5 elasticsearch elasticsearch 4096 Jun 19 03:18 indices
	-rw-r--r-- 1 elasticsearch elasticsearch 9517 Jun 19 03:18 meta-5OLxbdyAQn-yLKbsh_JrCg.dat
	-rw-r--r-- 1 elasticsearch elasticsearch  404 Jun 19 03:18 snap-5OLxbdyAQn-yLKbsh_JrCg.dat

Удалите индекс test и создайте индекс test-2.

	vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X PUT "localhost:9200/test-2?pretty" -H 'Content-Type: application/json' -d'
	> {
	>   "settings": {
	>     "number_of_shards": 1,
	>     "number_of_replicas": 0
	>   }
	> }
	> '
	
ответ  

	{
	  "acknowledged" : true,
	  "shards_acknowledged" : true,
	  "index" : "test-2"
	}
	
Приведите в ответе список индексов.

	vagrant@vagrant:$ curl 'localhost:9200/_cat/indices?pretty'
	green open test-2 H_5_Jdd5RhCVCUqeEZi06w 1 0 0 0 226b 226b
	
Восстановите состояние кластера elasticsearch из snapshot, созданного ранее.
Приведите в ответе запрос к API восстановления и итоговый список индексов.

	vagrant@vagrant:~$ curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_new/_restore?pretty" -H 'Content-Type: application/json' -d'
	> {
	>   "indices": "*",
	>   "include_global_state": true
	> }
	> '
	{
	  "error" : {
		"root_cause" : [
		  {
			"type" : "snapshot_restore_exception",
			"reason" : "[netology_backup:snapshot_new/UYeWGmnMRwij4nCq_bERvw] cannot restore index [.ds-.logs-deprecation.elasticsearch-default-2022.06.17-000001] because an open index with same name already exists in the cluster. Either close or delete the existing index or restore the index under a different name by providing a rename pattern and replacement name"
		  }
		],
		"type" : "snapshot_restore_exception",
		"reason" : "[netology_backup:snapshot_new/UYeWGmnMRwij4nCq_bERvw] cannot restore index [.ds-.logs-deprecation.elasticsearch-default-2022.06.17-000001] because an open index with same name already exists in the cluster. Either close or delete the existing index or restore the index under a different name by providing a rename pattern and replacement name"
	  },
	  "status" : 500
	}
Тут ошибка говорит, что есть такой индекс и надо закрыть или удалить индекс. Закрываем.

	vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X POST "localhost:9200/.ds-ilm-history-5-2022.06.19-000001/_close?pretty"
	{
	  "acknowledged" : true,
	  "shards_acknowledged" : true,
	  "indices" : {
		".ds-ilm-history-5-2022.06.19-000001" : {
		  "closed" : true
		}
	  }
	}

Востанавливаем

	vagrant@vagrant:/vagrant/dz6_5/docker$ curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_1/_restore?pretty" -H 'Content-Type: application/json' -d'
	{
	  "indices": "*",
	  "include_global_state": true
	}
	'
	{
	  "accepted" : true
	}

Список индексов. Есть востановленый индекс test:

	
	vagrant@vagrant:/vagrant/dz6_5/docker$ curl 'localhost:9200/_cat/indices?pretty'
	green open test-2 H_5_Jdd5RhCVCUqeEZi06w 1 0 0 0 226b 226b
	green open test   vszaBcc6SJqoYgnFs1sbdg 1 0 0 0 226b 226b

Подсказки:

    возможно вам понадобится доработать elasticsearch.yml в части директивы path.repo и перезапустить elasticsearch
