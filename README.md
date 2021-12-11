# Домашнее задание к занятию 3.6. Компьютерные сети, лекция 1  

## 1. Работа c HTTP через телнет.  

    Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80  
    отправьте HTTP запрос   

	GET /questions HTTP/1.0   
	HOST: stackoverflow.com   
	[press enter]   
	[press enter]   

    В ответе укажите полученный HTTP код, что он означает?   

Отправлено :  
	telnet stackoverflow.com 80  
	Trying 151.101.1.69...  
	Connected to stackoverflow.com.  
	Escape character is '^]'.  
	GET /questions HTTP/1.0  
	HOST: stackoverflow.com  

получено :  
	HTTP/1.1 400 Bad Request  
	Connection: close  
	Content-Length: 0  

	Connection closed by foreign host.   

Ошибка 400 Bad Request означает, что сервер (удалённый компьютер) не может обработать запрос, отправленный клиентом (браузером), вследствие проблемы, которая трактуется сервером как проблема на стороне клиента.  
### UPD. Вот скрин, при отправке GET висит и сообщает о закрытом подключении.
![](https://s283vla.storage.yandex.net/rdisk/80fb80f2d1173792c76c5cd2f2740ca5363bf81d016de7179d71aacc57c85889/61b4d69c/-yg_cLuuhfuAgJu7cu40CuECvUhv8AYD4sBDa2tUFeL8zkhT7bBtHzmUf0zr5mRg9AAbi_cMWOin0VIUgV2Evg==?uid=160010782&filename=UPD.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=434769&hid=1674d7e941636baa6c0f5a116caa612c&media_type=image&tknv=v2&etag=546d585dd6b485ba584ccdf05a3f41a0&rtoken=IjKWjTvA3cNL&force_default=yes&ycrid=na-d9291e325a7cf102ce19288465ccd195-downloader20f&ts=5d2e19faddf00&s=0463510440e9810fd3a834790047f674353e00450a3842f2e815c25dbc6b3d8b&pb=U2FsdGVkX1_5SivGq1XIYIkBgS5X_S_YMjzUd_NaoyM-mou_0SS5o1iMWMEWECPs59h3wT6EDXlwzr7HJEEiaSY8poGSQzzmSiJM2QPEKeY)  
## 2. Повторите задание 1 в браузере, используя консоль разработчика F12.  

    откройте вкладку Network  
    отправьте запрос http://stackoverflow.com  
    найдите первый ответ HTTP сервера, откройте вкладку Headers  
    укажите в ответе полученный HTTP код.  
    проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?  
    приложите скриншот консоли браузера в ответ.  

Судя по всему первый ответ это самый нижний в списке, он же и самый долгий  

полученный HTTP код:  
Код статуса: 200  

!(https://s340vla.storage.yandex.net/rdisk/ffbb0e5058db9bf87bacc0cb49fcda03873e7232844fcdc6b5736d6f8cb9d2fd/61b3ad70/-yg_cLuuhfuAgJu7cu40Cr0wIPFEDGlEQonyxou-em7oilnBfKKvKRKBhvA1cRudBZmur62A5S9hEXmtMCpfpg==?uid=160010782&filename=2%D0%B9%201.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=478695&hid=c1278e90ad3dfac4a82824fd2f469b32&media_type=image&tknv=v2&etag=2b56a78f7106b8e64aba46183f75edc2&rtoken=RUodiry8sSD6&force_default=yes&ycrid=na-12b953469e98363c7499c6b0b2751344-downloader8h&ts=5d2cfe9323c00&s=e631d2fa5b13aeae8f5fcf0a769620c18b7f85bacc4f53fee45bfd18d57ed78a&pb=U2FsdGVkX1_ZP-tL8VM4QctgdH0nmf5cQgULkBMQfQzn1kSvBWX_mqKDdW3BY10bNCIC9HE0X7IQ45DizNieNtTHZpeQSw-vP9kD5Xna8ew)  
!(https://s316sas.storage.yandex.net/rdisk/8e8411eea0069e7b447e832f304526e2c284c84920fd2b379c57b1c8b001418d/61b3ad88/-yg_cLuuhfuAgJu7cu40CuECvUhv8AYD4sBDa2tUFeL8zkhT7bBtHzmUf0zr5mRg9AAbi_cMWOin0VIUgV2Evg==?uid=160010782&filename=2%D0%B9.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=434769&hid=1674d7e941636baa6c0f5a116caa612c&media_type=image&tknv=v2&etag=546d585dd6b485ba584ccdf05a3f41a0&rtoken=WEZhWqCjB0aK&force_default=yes&ycrid=na-dc94bf7c56d0ff41e89303b47390fd6b-downloader8h&ts=5d2cfeaa07200&s=ac4a13b4da2b259e9b9de01b6db9368189065bf900ca2669d78fe77736a3312e&pb=U2FsdGVkX19aA5Hve5_3Q6Dz4XedlPlMJNRPaur7VcjFV3UovuF0HKRI1QLiFcIA8GXsKwKlYjpmaBHIcls4zR0hzNiN9RqQrajByH25S0Q)  

## 3. Какой IP адрес у вас в интернете?    
взят с помощью сервиса https://pr-cy.ru/  
92.63.69.9  

## 4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois  

Какому провайдеру принадлежит ваш IP адрес?    
	organisation:   ORG-TSU2-RIPE    
	org-name:       Tomsk State University    
Какой автономной системе AS?  
	AS8510    
 

## 5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute.   
В [AS*****] указаны AS  
sudo traceroute -AnI 8.8.8.8  
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets  
 1  10.0.2.2 [*]  0.106 ms  0.123 ms  0.088 ms  
 2  192.168.0.1 [*]  0.998 ms  1.018 ms  1.040 ms  
 3  172.16.0.1 [*]  10.462 ms  11.464 ms  11.540 ms  
 4  92.63.69.1 [AS8510]  3.310 ms  3.389 ms  3.471 ms  
 5  92.63.65.226 [AS8510]  2.395 ms  2.411 ms  2.507 ms  
 6  92.63.65.98 [AS8510]  2.520 ms  1.210 ms  1.330 ms  
 7  82.200.1.209 [AS21127]  4.210 ms  1.765 ms  1.740 ms  
 8  217.150.44.42 [AS20485]  6.792 ms  7.005 ms  7.084 ms  
 9  188.43.29.74 [AS20485]  5.601 ms  5.569 ms  5.602 ms  
10  188.43.29.49 [AS20485]  5.972 ms  6.227 ms  6.335 ms  
11  217.150.55.234 [AS20485]  41.074 ms  41.042 ms  49.631 ms  
12  188.43.10.141 [AS20485]  50.346 ms  50.416 ms  42.058 ms  
13  108.170.250.66 [AS15169]  44.287 ms  44.388 ms  44.409 ms  
14  * 209.85.255.136 [AS15169]  62.041 ms  62.074 ms  
15  172.253.65.82 [AS15169]  61.473 ms  61.751 ms  61.654 ms  
16  172.253.51.221 [AS15169]  61.959 ms  62.097 ms  61.988 ms  
17  * * *  
18  * * *  
19  * * *  
20  * * *  
21  * * *  
22  * * *  
23  * * *  
24  * * *  
25  * * *  
26  8.8.8.8 [AS15169]  53.343 ms  54.770 ms  54.960 ms  


## 6.Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?    
Наибольшая задержка на этом участке:    
 7. ge0-1-59.ll-tmk.zsttk.ru                              0.0%     9    9.5  42.5   4.5 208.3  71.7  

                                       My traceroute  [v0.93]  
vagrant (10.0.2.15)                                                        2021-12-10T08:45:52+0000  
Keys:  Help   Display mode   Restart statistics   Order of fields   quit  
                                                           Packets               Pings  
 Host                                                    Loss%   Snt   Last   Avg  Best  Wrst StDev  
 1. _gateway                                              0.0%     9    0.1   0.1   0.1   0.2   0.0  
 2. 192.168.0.1                                           0.0%     9    0.6   0.6   0.6   0.8   0.1  
 3. 172.16.0.1                                            0.0%     9    5.9   7.3   2.9  11.2   2.9  
 4. 92.63.69.1                                            0.0%     9    1.3   3.7   1.2  17.8   5.4  
 5. 92.63.65.226                                          0.0%     9    1.6   1.7   1.2   2.9   0.5  
 6. 92.63.65.98                                           0.0%     9    1.9   1.7   1.3   2.0   0.2  
 7. ge0-1-59.ll-tmk.zsttk.ru                              0.0%     9    9.5  42.5   4.5 208.3  71.7  
 8. tmk01.transtelecom.net                                0.0%     9   11.1  10.6   7.2  16.7   3.5  
 9. BL-gw.transtelecom.net                                0.0%     8    8.9  10.1   6.1  14.7   3.2  
10. BL-gw.transtelecom.net                                0.0%     8    9.3  12.2   7.6  16.6   3.3  
11. mskn15-Lo1.transtelecom.net                           0.0%     8   51.7  64.5  45.1  83.1  15.9  
12. Google-gw.transtelecom.net                            0.0%     8   50.9  45.4  40.5  50.9   3.9  
13. 108.170.250.66                                        0.0%     8   51.4  48.9  44.7  53.6   2.8  
14. 209.85.255.136                                       37.5%     8   53.7  56.3  53.7  59.7   2.4  
15. 172.253.65.82                                         0.0%     8   53.2  65.4  53.2 100.9  15.5  
16. 172.253.51.221                                        0.0%     8   64.7  63.4  58.9  66.8   3.1  
17. (waiting for reply)  
18. (waiting for reply)  
19. (waiting for reply)  
20. (waiting for reply)  
21. (waiting for reply)  
22. (waiting for reply)  
23. (waiting for reply)  
24. (waiting for reply)  
25. (waiting for reply)  
26. dns.google                                            0.0%     8   53.4  56.5  52.6  61.4   3.4  
  
## 7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig    
Вроде так:  
dig dns.google  

; <<>> DiG 9.16.1-Ubuntu <<>> dns.google  
;; global options: +cmd  
;; Got answer:  
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 45542  
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1  
  
;; OPT PSEUDOSECTION:  
; EDNS: version: 0, flags:; udp: 65494  
;; QUESTION SECTION:  
;dns.google.                    IN      A  
  
;; ANSWER SECTION:					А-записи это ниже:  
dns.google.             837     IN      A       8.8.8.8  
dns.google.             837     IN      A       8.8.4.4  

;; Query time: 47 msec   
;; SERVER: 127.0.0.53#53(127.0.0.53)  
;; WHEN: Fri Dec 10 11:30:01 UTC 2021  
;; MSG SIZE  rcvd: 71  

## 8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig    

dig -x 8.8.8.8  

; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.8.8  
;; global options: +cmd  
;; Got answer:  
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 34655  
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1  

;; OPT PSEUDOSECTION:  
; EDNS: version: 0, flags:; udp: 65494  
;; QUESTION SECTION:  
;8.8.8.8.in-addr.arpa.          IN      PTR  

;; ANSWER SECTION:					PTR-записи это ниже:  
8.8.8.8.in-addr.arpa.   85351   IN      PTR     dns.google.  

;; Query time: 47 msec  
;; SERVER: 127.0.0.53#53(127.0.0.53)  
;; WHEN: Fri Dec 10 13:43:00 UTC 2021  
;; MSG SIZE  rcvd: 73  
