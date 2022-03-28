# Домашнее задание к занятию 5.4. Оркестрация группой Docker контейнеров на примере Docker Compose  

## 1. Создать собственный образ операционной системы с помощью Packer.  
Для получения зачета, вам необходимо предоставить:  
    Скриншот страницы, как на слайде из презентации (слайд 37).


Ставим "УС" согластно документации:

        vagrant@vagrant:~$ curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
        ...тут пропустим вывод...
        vagrant@vagrant:~$ source "/home/vagrant/.bashrc" (чтоб шел не перезапускать)

Авторизируемся и проверяем конфиг и наличие чего либо:

    vagrant@vagrant:~$ yc init
    Welcome! This command will take you through the configuration process.
    Pick desired action:
     [1] Re-initialize this profile 'default' with new settings
     [2] Create a new profile
    Please enter your numeric choice: 1
    Please go to https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb in order to obtain OAuth token.
    
    Please enter OAuth token: [AQAAAAAJi*********************8lAdH2cFc]
    You have one cloud available: 'netologydz' (id = b1gcb120fc1jqt2pb8v3). It is going to be used by default.
    Please choose folder to use:
     [1] default (id = b1ggu84v03ph11de94u4)
     [2] Create a new folder
    Please enter your numeric choice: 2
    Please enter a folder name: dz54
    Your current folder has been set to 'dz54' (id = b1gb39m19vj7t0hm20cg).
    Do you want to configure a default Compute zone? [Y/n] Y
    Which zone do you want to use as a profile default?
     [1] ru-central1-a
     [2] ru-central1-b
     [3] ru-central1-c
     [4] Don't set default zone
    Please enter your numeric choice: 1
    Your profile default Compute zone has been set to 'ru-central1-a'.
    vagrant@vagrant:~$ yc config list
    token: AQAAAAAJi*********************8lAdH2cFc
    cloud-id: b1gcb120fc1jqt2pb8v3
    folder-id: b1gb39m19vj7t0hm20cg
    compute-default-zone: ru-central1-a
    vagrant@vagrant:~$ yc compute image list
    +----+------+--------+-------------+--------+
    | ID | NAME | FAMILY | PRODUCT IDS | STATUS |
    +----+------+--------+-------------+--------+
    +----+------+--------+-------------+--------+

~~ * Вот только не понял почему из консоли нельзя создать папку? AA понял, аккаунт был не платный, все решил~~  
Инициализация сети:  

        vagrant@vagrant:~$ yc vpc network create \
        > --name net \
        > --labels my-label=netologydz \
        > --description "my first network via yc"
        id: enpgb5f9k4d****
        folder_id: b1gph21***
        created_at: "2022-03-19T13:30:25Z"
        name: net
        description: my first network via yc
        labels:
          my-label: netologydz

Подсеть:

        vagrant@vagrant:~$ yc vpc subnet create \
        > --name my-subnet-a \
        > --zone ru-central1-a \
        > --range 10.1.2.0/24 \
        > --network-name net \
        > --description "my first subnet via yc"
        id: e9b72j1rtm**62
        folder_id: b1gph2160j***bi
        created_at: "2022-03-19T13:31:42Z"
        name: my-subnet-a
        description: my first subnet via yc
        network_id: enpgb5***
        zone_id: ru-central1-a
        v4_cidr_blocks:
        - 10.1.2.0/24



~~Тут не могу понять как решить ошибку сборки ВМ~~  
~~При запуске сборки выдает ошибку :~~  
~~https://disk.yandex.ru/i/pC-IhylgaD3wzA  
~~конфиг:  
~~https://disk.yandex.ru/i/XF7-iFLGBwCiPw~~  

~~Подскажите в чем моя ошибка и как это исправить , есть предположение что это как то связано с авторизацией~~  
Был косяк с конфигом , не верно токен указал (не убрал < >), id сети и папки верные.  

сделано   
![](https://s236vla.storage.yandex.net/rdisk/119dc393b2b9d678abf82dc982998e5edaba17d4a7bbd8dcb30ff3774d40f958/624226c8/-yg_cLuuhfuAgJu7cu40CkZI6hgbh8w_3l9F2J4ewHuHe-2CvbpuOEgT-l43R7-G6vfOFZfovh9alx3oa8auiQ==?uid=160010782&filename=1%D0%99.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=158717&hid=6efb45566acee7ea5a1f9f5795608ca1&media_type=image&tknv=v2&etag=562fdc5281a63435f284bf1dc4248709&rtoken=qcqhLTazyw52&force_default=yes&ycrid=na-d14dda5d5660ef74f185e9b138a8442d-downloader23f&ts=5db4de4414200&s=05cd0e1fcee1c2eed5fd59ab327e68564605e4c7d34b681753d96c55609cecdd&pb=U2FsdGVkX18GMOtHXnl5zHPeRjqBI0Zr-XW9VVE2A0Y9DIyh9CGy-19Ej1inJgRVI87tPtdQaOkr4oycyAIAjCBJwMpcVzPivfiGxySXtlU)  

##  2. Создать вашу первую виртуальную машину в Яндекс.Облаке.
Внеся нужные изменения(id папок облака и образа) делаем образ ВМ чз paсker:

    packer validate confdz54_cent.json
    packer build  confdz54_cent.json

И делаем ВМ через terraform:  

    terraform plan
    terraform apply

Сделано:  
![](https://s136vla.storage.yandex.net/rdisk/cd401b9ac9ec9564c390a0475edb0c5612516be925a1bfd7b9d6aaa7f292958d/62422724/-yg_cLuuhfuAgJu7cu40Crh0Dj-aO8jm7s-OCHR8GxuM_5-7HgGkVJP17_QeeaQrSIztHNTrtr-Tz9xB-ZqjyQ==?uid=160010782&filename=2%D0%B9.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=154128&hid=2ef1dcc321f45051aba95c7a653f84c5&media_type=image&tknv=v2&etag=8a763cf89d08b981d4a5f9f8748b6c68&rtoken=kbAlPeZ1m43A&force_default=yes&ycrid=na-24ca89e588d4157f378ecc50099755ce-downloader23f&ts=5db4de9bd1100&s=d44bafc1a2c78633e46785623c411f670388629b5638114cb86d77a6cb29ddaf&pb=U2FsdGVkX1_7yKmqxNVj3XgZ-evZ7ui1UptYpHOfO4PUYRslFDFPJa3tMVgxaNGDmmi1w_c3G1MCCX7_4Ri0dL9X21LL3O9jsRd97ZqbJio)  

## 3. Создать ваш первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов.
Для получения зачета, вам необходимо предоставить:  
Скриншот работающего веб-интерфейса Grafana с текущими метриками.

Тут надо с поможью ansible развернуть все что надо(есть в репозитории).

~~Записка для себя.   
Были беды с авторизацией. проблема была в том, что при сборке образа указывался один токен, а при подключении к ВМ при попытке запустить плэйбук ansible искал другой ключь. Если все время ссылаться на один и тот же ключь то все будет нормально(по умолчанию ~/.ssh/id_rsa.pub ). Так же не стоить путать ключь от служебного аккаунта и ключь для ssh который мы передаем, поскольку ключь сл.акка нужен для авторизации из консоли в облако, а те ключи на которые мы сылаемся при сборке пакером образа, и подключении ansible необходимы для подключения к самой ВМ запущеной в облаке.~~

![](https://s348vla.storage.yandex.net/rdisk/28e55c75b276af34d2797e50121b1b2627105e68aacd6b0d68fe1760a001965c/6242275b/-yg_cLuuhfuAgJu7cu40Cscswryqniyj1gqy8UbAXbIRsrVYgRcVJzJnHCpXOeT_N6Zu4IF_yJKA2MMOaoMbmQ==?uid=160010782&filename=3%D0%B9.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=280177&hid=c1cdb3145b0fe84a4c75e693b72a4744&media_type=image&tknv=v2&etag=8845684d1d884b85a76d8ca7a9a494e9&rtoken=ictCT5nKtYWN&force_default=yes&ycrid=na-a975ee01b4e28f82b7da4ee8030ba46d-downloader23f&ts=5db4ded044cc0&s=4215b3c44860781870a985ffbf115e5d19fc8c4b084f455e4bbdda38f216eb2f&pb=U2FsdGVkX1_OrY1d5ZL6u5xZLX-80d3bcptuindDkLFqzlujmX0w-Y0ZW4CDjmzC6zwqgAd8JefY_BWxoDniSHTSOhi77ee8hmkeN52LFk4)



