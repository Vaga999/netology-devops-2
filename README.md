# Домашнее задание к занятию 3.6. Компьютерные сети, лекция 2  

## 1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32

мой внешний адрес: 92.63.69.9

telnet route-views.routeviews.org
Username: rviews

route-views>show ip route 92.63.69.9
Routing entry for 92.63.64.0/20
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 1w1d ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 1w1d ago
      Route metric is 0, traffic share count is 1
      AS Hops 4
      Route tag 6939
      MPLS label: none

route-views>show bgp 92.63.69.9
BGP routing table entry for 92.63.64.0/20, version 2980717808
Paths: (23 available, best #13, table default)
  Not advertised to any peer
  Refresh Epoch 1
  57866 6453 20485 21127 8510
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 6453:50 6453:2000 6453:2300 6453:2305
      path 7FE14E67F208 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 174 20485 21127 8510
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external
      Community: 174:21101 174:22014 53767:5000
      path 7FE1790024E8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 3
  3303 20485 21127 8510
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external
      Community: 3303:1004 3303:1006 3303:1030 3303:1031 3303:3056 20485:10054 20485:65102 65101:1082 65102:1000 65103:276 65104:150
      path 7FE169E52188 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 20485 21127 8510
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external

## 2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

скрин1


## 3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

vagrant@vagrant:~$ sudo netstat -ntulp | grep LISTEN
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      617/systemd-resolve
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      813/sshd: /usr/sbin
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/init
tcp6       0      0 :::22                   :::*                    LISTEN      813/sshd: /usr/sbin
tcp6       0      0 :::111                  :::*                    LISTEN      1/init

2я и 3я строка порты 22 и 111 соответственно, используются процессами "813/sshd: /usr/sbin" и "1/init"  соответственно, сюда сожет подключиться любой Ip-адрес из интернета. 
Искользуется tcp, открытые порты 53,22,111.

## 4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

скрин2



## 5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

ссылка на файл













