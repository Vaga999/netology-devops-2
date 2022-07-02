# Домашнее задание к занятию "7.1. Инфраструктура как код"

## Задача 1 Выбор инструментов.
Легенда

Через час совещание на котором менеджер расскажет о новом проекте. Начать работу над которым надо будет уже сегодня. На данный момент известно, что это будет сервис, который ваша компания будет предоставлять внешним заказчикам. Первое время, скорее всего, будет один внешний клиент, со временем внешних клиентов станет больше.

Так же по разговорам в компании есть вероятность, что техническое задание еще не четкое, что приведет к большому количеству небольших релизов, тестированию интеграций, откатов, доработок, то есть скучно не будет.

Вам, как девопс инженеру, будет необходимо принять решение об инструментах для организации инфраструктуры. На данный момент в вашей компании уже используются следующие инструменты:

    остатки Сloud Formation,
    некоторые образы сделаны при помощи Packer,
    год назад начали активно использовать Terraform,
    разработчики привыкли использовать Docker,
    уже есть большая база Kubernetes конфигураций,
    для автоматизации процессов используется Teamcity,
    также есть совсем немного Ansible скриптов,
    и ряд bash скриптов для упрощения рутинных задач.

Для этого в рамках совещания надо будет выяснить подробности о проекте, что бы в итоге определиться с инструментами:

Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?

        Неизменяемый.

Будет ли центральный сервер для управления инфраструктурой?

        Нет. Управление будет с любой машины через Terraform/Ansible и Git. 

Будут ли агенты на серверах?

        Ansible позволяет использовать ssh без агентов.

Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?

        Да. Terraform/Ansible.

В связи с тем, что проект стартует уже сегодня, в рамках совещания надо будет определиться со всеми этими вопросами.
В результате задачи необходимо

Ответить на четыре вопроса представленных в разделе "Легенда".    
Какие инструменты из уже используемых вы хотели бы использовать для нового проекта?  

    Terraform, Ansible, Packer, Docker, Kubernetes  

Хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта?

    Возможно от TeamCity лучше отказаться в пользу GitLab CI/CD

Если для ответа на эти вопросы недостаточно информации, то напишите, какие моменты уточните на совещании.

## Задача 2. Установка терраформ.

Официальный сайт: https://www.terraform.io/

Установите терраформ при помощи менеджера пакетов используемого в вашей операционной системе. В виде результата этой задачи приложите вывод команды terraform --version.
Согластно документации [learn.hashicorp.com](https://learn.hashicorp.com/tutorials/terraform/install-cli)  

Проверяем версию

    vagrant@vagrant:~$ terraform -v  
    Terraform v1.2.4  
    on linux_amd64

## Задача 3. Поддержка легаси кода.

В какой-то момент вы обновили терраформ до новой версии, например с 0.12 до 0.13. А код одного из проектов настолько устарел, что не может работать с версией 0.13. В связи с этим необходимо сделать так, чтобы вы могли одновременно использовать последнюю версию терраформа установленную при помощи штатного менеджера пакетов и устаревшую версию 0.12.

В виде результата этой задачи приложите вывод --version двух версий терраформа доступных на вашем компьютере или виртуальной машине.

Один из вариантов: можно использовать для старой версии докер образ.   
Но я использовал этот способ:

    https://stackoverflow.com/questions/60113774/how-to-install-multiple-or-two-versions-of-terraform

<details>
    <summary>Спойлер</summary>
Делаем папки для разных версий:

    vagrant@vagrant:~$ sudo mkdir -p /usr/local/tf
    vagrant@vagrant:~$ sudo mkdir -p /usr/local/tf/11
Скачиваем бинарник терраформа : 
    
    vagrant@vagrant:/usr/local/tf/11$ wget https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip
    --2022-07-02 10:53:32--  https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip
    Resolving releases.hashicorp.com (releases.hashicorp.com)... 151.101.86.49
    Connecting to releases.hashicorp.com (releases.hashicorp.com)|151.101.86.49|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 12569267 (12M) [application/zip]
    terraform_0.11.14_linux_amd64.zip: Permission denied
    
    Cannot write to ‘terraform_0.11.14_linux_amd64.zip’ (Success).
    
    terraform_0.11.14_linux_amd64 100%[=================================================>]  11.99M   217KB/s    in 40s
    
    2022-07-02 10:54:38 (307 KB/s) - ‘terraform_0.11.14_linux_amd64.zip’ saved [12569267/12569267]

Ставим unzip:  

    vagrant@vagrant:/usr/local/tf/11$  sudo apt install unzip
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    Suggested packages:
      zip
    The following NEW packages will be installed:
      unzip
    0 upgraded, 1 newly installed, 0 to remove and 114 not upgraded.
    Need to get 168 kB of archives.
    After this operation, 567 kB of additional disk space will be used.
    Get:1 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 unzip amd64 6.0-21ubuntu1.1 [168 kB]
    Fetched 168 kB in 25s (6,654 B/s)
    Selecting previously unselected package unzip.
    (Reading database ... 39805 files and directories currently installed.)
    Preparing to unpack .../unzip_6.0-21ubuntu1.1_amd64.deb ...
    Unpacking unzip (6.0-21ubuntu1.1) ...
    Setting up unzip (6.0-21ubuntu1.1) ...
    Processing triggers for mime-support (3.60ubuntu1) ...
    Processing triggers for man-db (2.8.3-2ubuntu0.1) ...

Разархивируем

    vagrant@vagrant:/usr/local/tf/11$ sudo unzip terraform_0.11.14_linux_amd64.zip
    Archive:  terraform_0.11.14_linux_amd64.zip
      inflating: terraform
    vagrant@vagrant:/usr/local/tf/11$ ls -la
    total 49256
    drwxr-xr-x 2 root root     4096 Jul  2 13:00 .
    drwxr-xr-x 3 root root     4096 Jul  2 10:43 ..
    -rwxrwxr-x 1 root root 37858048 May 16  2019 terraform
    -rw-r--r-- 1 root root 12569267 May  9 16:38 terraform_0.11.14_linux_amd64.zip

Создайте символические ссылки для версий Terraform в /usr/bin/каталоге: 

    vagrant@vagrant:/usr/local/tf/11$ sudo ln -s /usr/local/tf/11/terraform /usr/bin/terraform11

Сделать символические ссылки исполняемыми:  

    vagrant@vagrant:~$ sudo chmod ugo+x /usr/bin/terraform*
</details> 

Теперь можно вызывать нужную версию терраформа согласно созданным ссылкам:
    
    vagrant@vagrant:~$ terraform -v
    Terraform v1.2.4
    on linux_amd64
    vagrant@vagrant:~$ terraform11 -v
    Terraform v0.11.14