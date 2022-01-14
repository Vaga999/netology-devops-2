# Домашнее задание к занятию 3.6. Компьютерные сети, лекция 3  

## 1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP  

telnet route-views.routeviews.org  
Username: rviews  
show ip route x.x.x.x/32  
show bgp x.x.x.x/32  

мой внешний адрес: 92.63.69.9  
### ввод:  
telnet route-views.routeviews.org  
Username: rviews  

### ввод:  
route-views>show ip route 92.63.69.9  
### вывод:
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

### ввод:  
route-views>show bgp 92.63.69.9  
### вывод:
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
### UPD  
![](https://s626man.storage.yandex.net/rdisk/0437647d7b10d601a0b0e31be4464f3b5d0d7fb9f181def18bfa19f1ce12e03b/61e1780f/-yg_cLuuhfuAgJu7cu40CgzAG6TuxHZoHhNukL2Wbyr_aSMB5scbyCP8Fy_Km99CkjibSQNGIBo-vxV9NPb-EA==?uid=160010782&filename=1%D0%B9.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=97399&hid=a05176665857ad431bdaa630ec23ac02&media_type=image&tknv=v2&etag=88bf63b3d9e2000cb4617e86c150025d&rtoken=OyR6cLt0kn9g&force_default=yes&ycrid=na-859f81f44b22ca84bcf3f132d5e091f5-downloader2e&ts=5d58aa232e1c0&s=c596b17e91999384c46ea5d2b8264eb2547f6846b2ff5fa17638e6ea8c9c2f15&pb=U2FsdGVkX1_FdT0OqGWqOrKcssvpg12-PX_4pZ0KaR6U0_NJXS4pfVn9PJbYofVuKjQ3XG2mzAZcB_aZeXWVFxnf4QHWMGQEgG8PmecBE4g)

Заметки.  
Loopback — это термин, который обычно используется для описания методов или процедур маршрутизации электронных сигналов, цифровых потоков данных, или других движущихся сущностей от их источника и обратно к тому же источнику без специальной обработки или модификаций. Первоначально он использовался для тестирования передачи или передающей инфраструктуры( Так, простейшим способом определения работоспособности стека TCP/IP или проведения его нагрузочного тестирования без вовлечения сетевого оборудования является посылка пакетов в loopback и прием их из него.). 
  
Любые сообщения, посылаемые на этот канал, немедленно принимаются тем же самым каналом.  

...реализуют виртуальный сетевой интерфейс исключительно программно и не связаны с каким-либо оборудованием, но при этом полностью интегрированы во внутреннюю сетевую инфраструктуру компьютерной системы. Любой трафик, который посылается компьютерной программой на интерфейс loopback тут же получается тем же интерфейсом...  

... Отличие интерфейсов tun и tap заключается в том, что tap старается больше походить на реальный сетевой интерфейс, а именно он позволяет себе принимать и отправлять ARP запросы, обладает MAC адресом и может являться одним из интерфейсов сетевого моста, так как он обладает полной поддержкой ethernet - протокола канального уровня (уровень 2). Интерфейс tun этой поддержки лишен, поэтому он может принимать и отправлять только IP пакеты и никак не ethernet кадры. Он не обладает MAC-адресом и не может быть добавлен в бридж. Зато он более легкий и быстрый за счет отсутствия дополнительной инкапсуляции и прекрасно подходит для тестирования сетевого стека или построения виртуальных частных сетей (VPN). Виртуальный интерфейс типа dummy очень похож на tap, разница лишь в том, что он реализуется другим модулем ядра....


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

![](https://s747sas.storage.yandex.net/rdisk/0d6d93904b9efd0741387daf6602854c1831e13bbc1a37f8f4891a47b3fc4786/61db2840/-yg_cLuuhfuAgJu7cu40ChH5NjlZEckvoA_zSa4Jhh1OJUQlrOCYv8Dw1wO6jwgxUnjysPgAoU1qpr4fYbIvYA==?uid=160010782&filename=2%D0%B9.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=156813&hid=3036048752cbcf1e27400b8528eb34af&media_type=image&tknv=v2&etag=652cfbabbb6b36979bd9cb55e628bd1d&rtoken=uXhCB2UBQe5U&force_default=yes&ycrid=na-0c9240f82be78565ae9f9df13b5155f4-downloader8e&ts=5d52a52ea9000&s=227f191a8dc9941ff8631f39311af3ac18dc61bf6d4c7c2c3231f7d26fe1f8a8&pb=U2FsdGVkX1-nvCmo2Zc0Lyr_80c5fyot4B_ZYaW3tcK4m1or8X289LxGN-cW6LosMFZrpf6SCReQR8jZr9ASowZOhzowNv2MZn77jlfCxKo)

## 5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.  

~~Незнаю на сколько верно поэтому опишу словами, возможно есть ошибки.  
Комп > роутр(с вбитой впнкой) > комутатор > (что дольше незнаю) но трасером посмотрел до  ip который уходит из сети организации к провайдеру:  

Трассировка маршрута к yandex.ru [5.255.255.88]  
с максимальным числом прыжков 30:  

  1    <1 мс    <1 мс    <1 мс  192.168.0.1  
  2     7 ms    <1 мс    <1 мс  172.16.0.1  
  3     1 ms    <1 мс    <1 мс  92.63.69.1  
  4    <1 мс    <1 мс    <1 мс  92.63.65.226  
  5     1 ms    <1 мс    <1 мс  92.63.65.98  
  6     8 ms     1 ms    <1 мс  ge0-1-59.ll-tmk.zsttk.ru [82.200.1.209]  (здесь начался провайдер)
  7     9 ms     6 ms    13 ms  tmk01.transtelecom.net [217.150.44.42]  
  
  И на основании этого я строил диаграмму.~~
UPD 
![](https://s276vla.storage.yandex.net/rdisk/9c07f721c12199cff77a05cd184c66a90e550134dd3e777aa893d107a130e45e/61e1799f/-yg_cLuuhfuAgJu7cu40ChimeGGqvH-Ocw5JEkW1XAOJJP-v1jSyTqpxejkW50UvFYINEZbbcbZefu7WswxcOQ==?uid=160010782&filename=Untitled%20Diagram.drawio.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=37275&hid=11c27c75bd53f6037ba776ba5a24655b&media_type=image&tknv=v2&etag=2f3b3ef8e25e5a0371324a0da2b2fe00&rtoken=jmQRcrFp0Wni&force_default=yes&ycrid=na-a78fdd83aceadb7f6c724a2ac9c8dfaa-downloader6h&ts=5d58aba0a65c0&s=8b1619258a1aa8b6147b84855ad799108a0ed3bfdf0c980653dd3e3cd49c7cee&pb=U2FsdGVkX1_hazoba3rgbuYPYjB3I8CuD2-uNbKhu4fhL1O6RWypY7Ahwn7UJ3qB6QL-H3aH8dO6XJb-vSYawQ01gLktg__lBUJAjlkuB9E)
