# Домашнее задание к занятию 3.5. Файловые системы

## 1. Узнайте о sparse (разряженных) файлах. 
Разреженные – это специальные файлы, которые с большей эффективностью используют файловую систему.Пустая информация в виде нулей, будет хранится в блоке метаданных ФС. Поэтому, разреженные файлы изначально занимают меньший объем носителя, чем их реальный объем.
https://habr.com/ru/company/hetmansoftware/blog/553474/
https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB

## 2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Жесткие ссылки выглядят в файловой структуре как еще один файл. Жесткая ссылка и файл, для которой она создавалась имеют одинаковые inode. Поэтому жесткая ссылка имеет те же права доступа, владельца и время последней модификации, что и целевой файл. Различаются только имена файлов. Фактически жесткая ссылка это еще одно имя для файла. Таким образом ссылка имеет тот же inode что и файл следовательно права будут теже , что и у файла.

vagrant@vagrant:/home$ sudo  touch Filee
vagrant@vagrant:/home$ ls -la
total 60
drwxr-xr-x  3 root    root     4096 Dec  1 10:44 .
drwxr-xr-x 20 root    root     4096 Nov 21 13:35 ..
-rw-r--r--  1 root    root        0 Dec  1 10:44 Filee
drwxr-xr-x  5 vagrant vagrant 53248 Nov 26 07:48 vagrant
vagrant@vagrant:/home$ sudo ln Filee FileeLink
vagrant@vagrant:/home$ ls -li
total 52
131088 -rw-r--r-- 2 root    root        0 Dec  1 10:44 Filee
131088 -rw-r--r-- 2 root    root        0 Dec  1 10:44 FileeLink
131074 drwxr-xr-x 5 vagrant vagrant 53248 Nov 26 07:48 vagrant

## 3. Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

Vagrant.configure("2") do |config|
....  ....
end

Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.
Из Vagrantfile создать не получилось(была ошибка при выполнении строк:
vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]  
vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]) 
Сделал чз интерфейс VirtualBox .

vagrant@vagrant:~$ sudo lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm  /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm  [SWAP]
sdb                    8:16   0  2.5G  0 disk
sdc                    8:32   0  2.5G  0 disk

## 4. Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

ДО 

vagrant@vagrant:~$ sudo fdisk -l /dev/sdb
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

После
vagrant@vagrant:~$ sudo fdisk -l /dev/sdb
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: D804653D-3DF3-D746-BDB8-0E37980E2080

Device       Start     End Sectors  Size Type
/dev/sdb1     2048 4196351 4194304    2G Linux filesystem
/dev/sdb2  4196352 5242846 1046495  511M Linux filesystem


## 5. Используя sfdisk, перенесите данную таблицу разделов на второй диск.

сделано
 !(https://disk.yandex.ru/i/hmndy1BCkYS1Vw)

## 6. Соберите mdadm RAID1 на паре разделов 2 Гб.

Занулить суперблоки на дисках, которые мы будем использовать для построения RAID для удаления служебной информации:  
sudo mdadm --zero-superblock --force /dev/sd{b1,c1}  

Удалить старые метаданные и подпись на дисках:  
wipefs --all --force /dev/sd{b1,c1}  

Сборка избыточного массива:  
sudo mdadm --create --verbose /dev/md1 -l 1 -n 2 /dev/sd{b1,c1}  

!(https://disk.yandex.ru/i/IZekbS8YnWdyDw)

## 7. Соберите mdadm RAID0 на второй паре маленьких разделов.

Занулить суперблоки на дисках, которые мы будем использовать для построения RAID для удаления служебной информации:  
sudo mdadm --zero-superblock --force /dev/sd{b2,c2}  

Удалить старые метаданные и подпись на дисках:  
wipefs --all --force /dev/sd{b2,c2}  

Сборка избыточного массива:  
sudo mdadm --create --verbose /dev/md1 -l 1 -n 2 /dev/sd{b2,c2}  

!(https://disk.yandex.ru/i/fijra8CsNJo3IA)

## 8. Создайте 2 независимых PV на получившихся md-устройствах.
Как понял это для инициализации дисков.
pvcreate /dev/md1 /dev/md0

/dev/md1 и /dev/md0 пути к дискам.
Сделано.
vagrant@vagrant:/vagrant$ sudo pvcreate /dev/md1 /dev/md0
  Physical volume "/dev/md1" successfully created.
  Physical volume "/dev/md0" successfully created.

vagrant@vagrant:/vagrant$  sudo pvscan
  PV /dev/sda5   VG vgvagrant       lvm2 [<63.50 GiB / 0    free]
  PV /dev/md0                       lvm2 [1017.00 MiB]
  PV /dev/md1                       lvm2 [<2.00 GiB]
  Total: 3 [<66.49 GiB] / in use: 1 [<63.50 GiB] / in no VG: 2 [2.99 GiB]  

## 9. Создайте общую volume-group на этих двух PV.  

sudo vgcreate volume_group1 /dev/md1 /dev/md0

sudo vgdisplay

!(https://disk.yandex.ru/i/_gnQHevXeZVdlw) 

## 10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.  

sudo lvcreate -L 100M -n logical_vol1 volume_group1  

 --- Logical volume ---
  LV Path                /dev/volume_group1/logical_vol1
  LV Name                logical_vol1
  VG Name                volume_group1
  LV UUID                7lj23d-9F0S-b10v-jvs6-RWOh-ABtC-oQ2kJa
  LV Write Access        read/write
  LV Creation host, time vagrant, 2021-12-03 10:41:45 +0000
  LV Status              available
  \# open                 0
  LV Size                100.00 MiB
  Current LE             25
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:2

## 11. Создайте mkfs.ext4 ФС на получившемся LV.  

vagrant@vagrant:/vagrant$ sudo mkfs.ext4 /dev/volume_group1/logical_vol1
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

## 12. Смонтируйте этот раздел в любую директорию, например, /tmp/new.  

mkdir /tmp/newdir
sudo mount /dev/volume_group1/logical_vol1 /tmp/newdir

## 13. Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz. 
 
vagrant@vagrant:/vagrant$ sudo wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/newdir/test.gz
--2021-12-03 11:14:33--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22610382 (22M) [application/octet-stream]
Saving to: ‘/tmp/newdir/test.gz’

/tmp/newdir/test.gz         100%[===========================================>]  21.56M  2.09MB/s    in 13s

2021-12-03 11:14:46 (1.66 MB/s) - ‘/tmp/newdir/test.gz’ saved [22610382/22610382]

## 14. Прикрепите вывод lsblk.

vagrant@vagrant:/vagrant$ lsblk
NAME                             MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                                8:0    0   64G  0 disk
├─sda1                             8:1    0  512M  0 part  /boot/efi
├─sda2                             8:2    0    1K  0 part
└─sda5                             8:5    0 63.5G  0 part
  ├─vgvagrant-root               253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1             253:1    0  980M  0 lvm   [SWAP]
sdb                                8:16   0  2.5G  0 disk
├─sdb1                             8:17   0    2G  0 part
│ └─md1                            9:1    0    2G  0 raid1
│   └─volume_group1-logical_vol1 253:2    0  100M  0 lvm   /tmp/newdir
└─sdb2                             8:18   0  511M  0 part
  └─md0                            9:0    0 1017M  0 raid0
sdc                                8:32   0  2.5G  0 disk
├─sdc1                             8:33   0    2G  0 part
│ └─md1                            9:1    0    2G  0 raid1
│   └─volume_group1-logical_vol1 253:2    0  100M  0 lvm   /tmp/newdir
└─sdc2                             8:34   0  511M  0 part
  └─md0                            9:0    0 1017M  0 raid0


## 15. Протестируйте целостность файла:

vagrant@vagrant:/vagrant$ gzip -t /tmp/newdir/test.gz
vagrant@vagrant:/vagrant$ echo $?
0
 
## 16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

vagrant@vagrant:/vagrant$ sudo pvmove /dev/md1
  /dev/md1: Moved: 64.00%
  /dev/md1: Moved: 100.00%
vagrant@vagrant:/vagrant$ lsblk
NAME                             MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                                8:0    0   64G  0 disk
├─sda1                             8:1    0  512M  0 part  /boot/efi
├─sda2                             8:2    0    1K  0 part
└─sda5                             8:5    0 63.5G  0 part
  ├─vgvagrant-root               253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1             253:1    0  980M  0 lvm   [SWAP]
sdb                                8:16   0  2.5G  0 disk
├─sdb1                             8:17   0    2G  0 part
│ └─md1                            9:1    0    2G  0 raid1
└─sdb2                             8:18   0  511M  0 part
  └─md0                            9:0    0 1017M  0 raid0
    └─volume_group1-logical_vol1 253:2    0  100M  0 lvm   /tmp/newdir
sdc                                8:32   0  2.5G  0 disk
├─sdc1                             8:33   0    2G  0 part
│ └─md1                            9:1    0    2G  0 raid1
└─sdc2                             8:34   0  511M  0 part
  └─md0                            9:0    0 1017M  0 raid0
    └─volume_group1-logical_vol1 253:2    0  100M  0 lvm   /tmp/newdir

## 17. Сделайте --fail на устройство в вашем RAID1 md.

vagrant@vagrant:/vagrant$ sudo mdadm /dev/md1 --fail /dev/sdb1
mdadm: set /dev/sdb1 faulty in /dev/md1
vagrant@vagrant:/vagrant$ cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
md0 : active raid0 sdc2[1] sdb2[0]
      1041408 blocks super 1.2 512k chunks

md1 : active raid1 sdc1[1] sdb1[0](F)
      2094080 blocks super 1.2 [2/1] [_U]

unused devices: <none>

## 18. Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.

vagrant@vagrant:/vagrant$ dmesg |grep md1
[22503.907586] md/raid1:md1: not clean -- starting background reconstruction
[22503.907588] md/raid1:md1: active with 2 out of 2 mirrors
[22503.907601] md1: detected capacity change from 0 to 2144337920
[22503.912399] md: resync of RAID array md1
[22514.081365] md: md1: resync done.
[44137.484772] md/raid1:md1: Disk failure on sdb1, disabling device.
               md/raid1:md1: Operation continuing on 1 devices.


## 19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:
vagrant@vagrant:/vagrant$ gzip -t /tmp/newdir/test.gz
vagrant@vagrant:/vagrant$ echo $?
0

## 20. Погасите тестовый хост, vagrant destroy.
сделано


