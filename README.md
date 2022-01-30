# Домашнее задание к занятию 3.9. Элементы безопасности информационных систем    

## 1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.    

сделано.  
![](скрин 1й)  

## 2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.    

сделано.  
![](скрин 2й)  


## 3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.  

~~(делалось по https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-18-04-ru?__cf_chl_managed_tk__=iXUCb.VP.2SttUCNMOmGo7Le9Iom.Outv7Uy7Hf8QwA-1643112058-0-gaNycGzNDJE)~~  

Установите apache2: сделано  
![](3й скрин)  

сгенерируйте самоподписанный сертификат(сделано)  

настройте тестовый сайт (тот который идет с апачем) для работы по HTTPS.  


## 4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).    

(сслыка на файлы уязвимость)  

## 5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.  

Сделал 2е виртуальные машины. 1я как сервер , 2я как клиент. На клиенте создана пара ключей:    
ssh-keygen  
и передана на сервер:  
ssh-copy-id vagrant@192.168.0.103  
вывод:  
vagrant@vagrant:~$ ssh-copy-id vagrant@192.168.0.103  
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/vagrant/.ssh/id_rsa.pub"  
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed  
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys  
vagrant@192.168.0.103's password:  

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'vagrant@192.168.0.103'"  
and check to make sure that only the key(s) you wanted were added.  

Далее подключаемся к серверу на который отдали ключь:  
 
$ ssh vagrant@192.168.0.103  

Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-80-generic x86_64)  

 * Documentation:  https://help.ubuntu.com  
 * Management:     https://landscape.canonical.com  
 * Support:        https://ubuntu.com/advantage  

  System information as of Fri 28 Jan 2022 06:14:08 AM UTC  

  System load:  0.0               Processes:             104  
  Usage of /:   2.7% of 61.31GB   Users logged in:       1  
  Memory usage: 7%                IPv4 address for eth0: 10.0.2.15  
  Swap usage:   0%                IPv4 address for eth1: 192.168.0.103  


This system is built by the Bento project by Chef Software  
More information can be found at https://github.com/chef/bento  
Last login: Fri Jan 28 06:05:18 2022 from 192.168.0.104 

Это значит подключение произошло.   

## 6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.    

Переименуйте файлы ключей из задания 5. Тут непонятки : Надо сам файл ключа на сервере переименовать?  

Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.- Сделано.      

На клиентской машине в файл hosts вписан адрес хоста и имя:  
vagrant@vagrant:/etc$ sudo nano hosts  

127.0.0.1       localhost  
127.0.1.1       vagrant.vm      vagrant  
192.168.0.101   vagrant.vm      vagrant1  <<<эта строка добавлена    

\# The following lines are desirable for IPv6 capable hosts    
::1     localhost ip6-localhost ip6-loopback  
ff02::1 ip6-allnodes  
ff02::2 ip6-allrouters  

далее на клиенте вводим:  ssh vagrant@vagrant1  

и происходит подключение:  

vagrant@vagrant:/etc$ ssh vagrant@vagrant1  
The authenticity of host 'vagrant1 (192.168.0.101)' can't be established.  
ECDSA key fingerprint is SHA256:wSHl+h4vAtTT7mbkj2lbGyxWXWTUf6VUliwpncjwLPM.  
Are you sure you want to continue connecting (yes/no/[fingerprint])? y  
Please type 'yes', 'no' or the fingerprint: yes  
Warning: Permanently added 'vagrant1' (ECDSA) to the list of known hosts.  
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-80-generic x86_64)  

 * Documentation:  https://help.ubuntu.com  
 * Management:     https://landscape.canonical.com  
 * Support:        https://ubuntu.com/advantage  

  System information as of Sat 29 Jan 2022 05:03:18 PM UTC  

  System load:  0.08              Processes:             114  
  Usage of /:   2.7% of 61.31GB   Users logged in:       1  
  Memory usage: 7%                IPv4 address for eth0: 10.0.2.15  
  Swap usage:   0%                IPv4 address for eth1: 192.168.0.101  


This system is built by the Bento project by Chef Software  
More information can be found at https://github.com/chef/bento  
Last login: Sat Jan 29 17:01:18 2022 from 10.0.2.2  
vagrant@vagrant:~$ logout  

## 6. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.    

Для сбора трафика:  
sudo tcpdump -c 100 -w dump.pcap (единственное непонял почему надо нажать enter для того чтоб все выполнилось, а то после запуска команды терминал ни чего не отображает (пример скрин))    

получаем  файл(ссылку на dump.pcap)  

Откройте файл pcap в Wireshark. сделано  
![](ссылка 6й)  




















