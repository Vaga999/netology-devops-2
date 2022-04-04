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
![](https://s236vla.storage.yandex.net/rdisk/780943f0fe05ef7df8bb4030efcc87793ad87c5af7ac8f227f7b74761c5ed347/624b468a/-yg_cLuuhfuAgJu7cu40CkZI6hgbh8w_3l9F2J4ewHuHe-2CvbpuOEgT-l43R7-G6vfOFZfovh9alx3oa8auiQ==?uid=160010782&filename=1%D0%99.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=158717&hid=6efb45566acee7ea5a1f9f5795608ca1&media_type=image&tknv=v2&etag=562fdc5281a63435f284bf1dc4248709&rtoken=nuykk7bYgVml&force_default=yes&ycrid=na-1e573492e53b95a3fceab26d2deffb3f-downloader1f&ts=5dbd91d173680&s=03e2ee12d5c5d4d71da6667e3d6f452dd0bf6fadd251900fafe9c44043da451b&pb=U2FsdGVkX1_Z1rmXEMlHVaUXoZPYnRjPiVQe2UjP-xixzUf6iJDJZk5v6VpkCrVRqBc6Xi62PIxnsfZilCYcn5rVoY8Hm38Y8qUTKNKy9tk)  

##  2. Создать вашу первую виртуальную машину в Яндекс.Облаке.
Внеся нужные изменения(id папок облака и образа) делаем образ ВМ чз paсker:

    packer validate confdz54_cent.json
    packer build  confdz54_cent.json

И делаем ВМ через terraform:  

    terraform plan
    terraform apply

Сделано:  
![](https://s754sas.storage.yandex.net/rdisk/99ffdc55c7483e69f470cf30703685fbaaefc221fa82fe1d4d67df820ca2e072/624b46a8/-yg_cLuuhfuAgJu7cu40Crh0Dj-aO8jm7s-OCHR8GxuM_5-7HgGkVJP17_QeeaQrSIztHNTrtr-Tz9xB-ZqjyQ==?uid=160010782&filename=2%D0%B9.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=154128&hid=2ef1dcc321f45051aba95c7a653f84c5&media_type=image&tknv=v2&etag=8a763cf89d08b981d4a5f9f8748b6c68&rtoken=Z1LJpKNQvL7d&force_default=yes&ycrid=na-95f27245d2f0e8e55ef8fa4ca5425137-downloader1f&ts=5dbd91ee0fa00&s=e61d94a9d1023e46861416b13924347051680ee00f5a95cb99915bac67e4cbaf&pb=U2FsdGVkX1-jKCfAiUZ0_rIYnweEsrIydX2s5-HAxJNC5EcQi7ZxxN0mJe5m1pjWbJRt-JvYSimYM1UrB-RloI-oaoy8Cuo3TVqWc7tVXpo)  

## 3. Создать ваш первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов.
Для получения зачета, вам необходимо предоставить:  
Скриншот работающего веб-интерфейса Grafana с текущими метриками.

Тут надо с поможью ansible развернуть все что надо(есть в репозитории).

~~Записка для себя.   
Были беды с авторизацией. проблема была в том, что при сборке образа указывался один токен, а при подключении к ВМ при попытке запустить плэйбук ansible искал другой ключь. Если все время ссылаться на один и тот же ключь то все будет нормально(по умолчанию ~/.ssh/id_rsa.pub ). Так же не стоить путать ключь от служебного аккаунта и ключь для ssh который мы передаем, поскольку ключь сл.акка нужен для авторизации из консоли в облако, а те ключи на которые мы сылаемся при сборке пакером образа, и подключении ansible необходимы для подключения к самой ВМ запущеной в облаке.~~

![](https://s757sas.storage.yandex.net/rdisk/ff3036c82c6e6a9e3333df032742b208d8ec3049e0ff97983dd651cdf7a13589/624b46f4/-yg_cLuuhfuAgJu7cu40Cscswryqniyj1gqy8UbAXbIRsrVYgRcVJzJnHCpXOeT_N6Zu4IF_yJKA2MMOaoMbmQ==?uid=160010782&filename=3%D0%B9.jpg&disposition=inline&hash=&limit=0&content_type=image%2Fjpeg&owner_uid=160010782&fsize=280177&hid=c1cdb3145b0fe84a4c75e693b72a4744&media_type=image&tknv=v2&etag=8845684d1d884b85a76d8ca7a9a494e9&rtoken=r4CVhrMQK116&force_default=yes&ycrid=na-dbfa94c5003f4359b6e9e1fc6e6d02b7-downloader1f&ts=5dbd92368a500&s=8f376899346e4151f7fd454c1cf082193e458f4ba3d2fc94c4412ddde0e9801d&pb=U2FsdGVkX19FThn7cw_I18H9lKPSi2gf7lVGXvQfInh2-sFErYlJ_JTzmWfKNQahHv9ttS7lRNf_7rcSKf5_rBjkxTkI042QD6sQI9EZ-60)



