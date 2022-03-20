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
        id: enpgb5f9k4daav7tt3vm
        folder_id: b1gph2160jl3ca6ffrbi
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
        id: e9b72j1rtmbbg3e2ir62
        folder_id: b1gph2160jl3ca6ffrbi
        created_at: "2022-03-19T13:31:42Z"
        name: my-subnet-a
        description: my first subnet via yc
        network_id: enpgb5f9k4daav7tt3vm
        zone_id: ru-central1-a
        v4_cidr_blocks:
        - 10.1.2.0/24



## Тут не могу понять как решить ошибку сборки ВМ
При запуске сборки выдает ошибку :
https://disk.yandex.ru/i/pC-IhylgaD3wzA
конфиг:
https://disk.yandex.ru/i/XF7-iFLGBwCiPw

Подскажите в чем моя ошибка и как это исправить
есть предположение что это как то связано с авторизацией





