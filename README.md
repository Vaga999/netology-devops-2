# Домашнее задание к занятию 3.6. Компьютерные сети, лекция 2  

## 1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?  

Для командной строки Windows можно использовать:  
ipconfig -all  
netstat или netstat -n  
route PRINT  

из PowerShell (модуль NetTCPIP):    
Get-NetAdapter   

В Linux:   
ip link show  
ip addr  
ip -s link   
Эти команды еще и показывают состояяние интерфейса.  
![](https://s325vla.storage.yandex.net/rdisk/5b951395a12ce04aef52c1dbc8b25a31f7e5315dabbc939ee151111b293fc2f8/61c0d12b/-yg_cLuuhfuAgJu7cu40ChHLLBSagJp3ufWvsC_Y5Z9FE0_fYEKnT3uuhNzRcCqlPKEZyNjG7Yy0-DUzhQDu1g==?uid=160010782&filename=1%D0%B9.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=203638&hid=4451163d590515955caca016d0495b4c&media_type=image&tknv=v2&etag=9786a6cd2617cd2e145eaf54dc8ffa6e&rtoken=QlSj1TEUAozB&force_default=yes&ycrid=na-068796d571540bf6de690f4b1badf775-downloader5f&ts=5d39867a660c0&s=88e67a1e888dbbd8502fd4279672e98de95a966dd9a123188b46ae2e1ecc295a&pb=U2FsdGVkX1-It4GvXULqDypHc6sEWSsGV2jmmG_0HWKkQFpLuvj04tnbfQz0fRtdTC2aJz0KBX5Z3qfz3ReFDK7FdudhoFOEd1cZA3afdvE)  


так же :   
ls /sys/class/net    
cat /proc/net/dev   


## 2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?   
Протоколы LLDP ,  NDP  

Посмотреть можно например так:    
sudo nmap -sn 192.xxx.xxx.xxx/xx  

sudo arp-scan --interface=eth0 --localnet  
![](https://s277vla.storage.yandex.net/rdisk/0f08073a557a1740acfbc41d959a94cc2cf4f535a0e937f1c8760b8d85203bee/61c0d13c/-yg_cLuuhfuAgJu7cu40CgsnrHWAuWQD0QU6yQav3_-_SYAuy5bkSujWv3gehcx3VugZO4uU-WMyilZD0edF7A==?uid=160010782&filename=2%D0%B9.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=147535&hid=61b6d9cf5ce6d84577c923d9f3c3273f&media_type=image&tknv=v2&etag=76f8ea2b54f203af3a465adf4846a1e3&rtoken=8QaaxWarWrUD&force_default=yes&ycrid=na-5571f0d425a3500244d6ef6cd8929e0c-downloader5f&ts=5d39868a9c700&s=060fa80ef4d4d83e6562295cd0cb1afe99b14ddb1bedd695ba1591da91120c88&pb=U2FsdGVkX1_DbRiM5TmhbCT0mRQwr7_fjYMH4XLlxixolRUbQzFxvmeo32qQxsNnRRrs10bporBwD_tSx8aXGz5Flx-EZXXojTnodFMxl9A)  

## UPD.  
 С помощью инструмента lldpd, для управления им есть lldpcli:    
lldpcli show neighbors  
-------------------------------------------------------------------------------  
LLDP neighbors:  
-------------------------------------------------------------------------------  
Interface:    eth1, via: LLDP, RID: 1, Time: 0 day, 00:25:01  
  Chassis:  
    ChassisID:    mac 88:d7:f6:c6:36:34  
  Port:  
    PortID:       mac 88:d7:f6:c6:36:34  
    TTL:          3601  
-------------------------------------------------------------------------------  

## 3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.  

VLAN – виртуальное разделение коммутатора  

Список и настройки можно посмотреть здесь:  
/etc/network/interfaces  
мой пример(создает два vlan) :    
auto eth0.100  
iface eth0.100 inet static  
   address 192.168.100.3  
   netmask 255.255.255.0  
   vlan_raw_device eth0  

auto eth0.200  
iface eth0.200 inet static  
   address 192.168.200.3  
   netmask 255.255.255.0  
   vlan_raw_device eth0  

![](https://s288vla.storage.yandex.net/rdisk/822609f74239a80b08a230ee99e31e0c6be2523c16c5673bb0c2e3c0f30b327a/61c0d14b/-yg_cLuuhfuAgJu7cu40Cq0d3In33MxFhNMSBjCjL47pzFSODICzp1U7JszO_0j9_4jgwurVU509-nFkNyj4SA==?uid=160010782&filename=3%D0%B9.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=251803&hid=75f4f7b6f2e967fc98e776e0fc6813d6&media_type=image&tknv=v2&etag=2ed06d358ef9442d0b02fc1d1842bff8&rtoken=xANVuPzHxDyh&force_default=yes&ycrid=na-26b55140b56626d6b4656de057a5b1c4-downloader5f&ts=5d398698ea8c0&s=2d719e052357a5ef28d7cb78b43afa63bbb0c89c244776943e5e0888f49dcfac&pb=U2FsdGVkX18BPkMFYTROUUYo3Q_Cbp4BoWgKnbPW-nP0CH78N-Ijk9iIuCxDQLOcPz2UE5T4TEzh1LNlfDsz_1GdzAbI9qjSvuCingCdjIk)   

пакет vconfig  
например:    
vconfig add eth0 1678  мы добавили vlan для устройства eth0, и ид vlan будет 1678    
Но этот способ не позволит создать vlan способный подняться носле перезагрузки системы  

есть IPRoute2 (как я понял это более новое)  

## 4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.    

Драйвер bonding ядра linux обеспечивает метод агрегации нескольких сетевых интерфейсов в единый логический bonded интерфейс. Поведение агрегированных ("bonded") интерфейсов зависит от режима ("mode").  

Mode-0(balance-rr) В данном режиме сетевые пакеты отправляются “по кругу”, от первого интерфейса к последнему. Если выходят из строя интерфейсы, пакеты отправляются на остальные оставшиеся.   
Mode-1(active-backup) Один из интерфейсов работает в активном режиме, остальные в ожидающем.   
Mode-2(balance-xor) Передачи распределяются между интерфейсами на основе формулы ((MAC-адрес источника) XOR (MAC-адрес получателя)) % число интерфейсов. Один и тот же интерфейс работает с определённым получателем.   
Mode-3(broadcast) Происходит передача во все объединенные интерфейсы, тем самым обеспечивая отказоустойчивость.   
Mode-4(802.3ad)  динамическое объединение одинаковых портов.   
Mode-5(balance-tlb)  Адаптивная балансировки нагрузки трафика. Входящий трафик получается только активным интерфейсом, исходящий распределяется в зависимости от текущей загрузки канала каждого интерфейса.  
Mode-6(balance-alb) – Адаптивная балансировка нагрузки. Отличается более совершенным алгоритмом балансировки нагрузки чем Mode-5). Обеспечивается балансировку нагрузки как исходящего так и входящего трафика.   

пример конфига(это из интернета, я пока не понял где брать address, gateway,netmask, network,dns-nameservers). система запускается, в устройствах появляется нужный нам bond0 но по ssh подключиться не могу.  
содержимое /etc/network/interfaces:    
auto eth0   
iface eth0 inet manual   
bond-master bond0   

auto eth1   
iface eth1 inet manual   
bond-master bond0   

auto bond0   
iface bond0 inet static   
address 10.200.6.8   
gateway 10.200.6.6   
netmask 255.255.255.0   
network 10.200.6.0   
dns-nameservers 10.200.6.6   
bond-mode 0   
bond-miimon 100   
bond-slaves eth0 eth1  

## 5. Сколько IP адресов в сети с маской /29 ? Сколько подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.   

#### Сколько IP адресов в сети с маской /29 ?    
32-29=3(всего 32 бита, занято 29)  
2^3=8(2 комбинации в степени = свободных бит )  
8-2=6 (1й адрес сети, 2й для Broadcast)   

#### Сколько /29 подсетей можно получить из сети с маской /24?  
/24 это 255.255.255.0 >> 2^8=256  
~~(всего рабочих адресов 256-2=254)  
(на каждую подсеть нам надо минимум 3и ip следовательно 256/3=84,66; Но дробное нам не надо, берем число 84(сетей)  (поэтому будет 83 сети с 3мя адресами и +1 с 4мя адресами)).~~  
Нам нужны подсети /29 это по 8 адресов(всего) есть 254 рабочих адреса(и 2а служебных), >>> 254/8=31,75  итого 31 подсеть(в одной из подсетей будет 9 аресов, а не 8).    

#### Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.    

диапазон(вместе со служебными) 10.10.10.2 - 10.10.10.10  
маска 255.255.255.248  

диапазон (вместе со служебными) 10.10.10.10 - 10.10.10.18  
маска 255.255.255.248  
## UPD
Не понял что именно я не верно сделал.  


## 6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.  

~~если не будет прямого выхода в интернет то любые адреса можно брать, с маской /26~~    
 у нас есть такие рекомендованые диапазоны для локальной сети:  
	10.10.0.0 – 10.255.255.255 – сеть класса A, возможно до 16121856 различных адресов хостов.   

	172.16.0.0 – 172.31.255.255 – группа 16-ти смежных сетей класса B, можно использовать до различных 1048576 адресов хостов.  

	192.168.0.0 – 192.168.255.255 – группа 16-ти смежных сетей класса C, возможно до различных 65536 адресов хостов.  

~~Думаю можно взять из 192.168.1.0 с маской/26.~~  

## UPD  
Мне ни чего не приходит на ум как 100.64.0.0 — 100.127.255.255 (маска подсети 255.192.0.0 или /10)  
Или 198.18.0.0–198.19.255.255  

## 7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?  

Windows:  
arp -a  

Linux:   
arp -a  
и утилита arp-scan   

Для полной очистки таблицы(windows, linux):  
arp -d   
для удаления строки arp -d [имя хоста или его IP]  