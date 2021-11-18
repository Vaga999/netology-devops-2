# Домашнее задание к занятию "3.3. Операционные системы, лекция 1"  
## 1. Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. Вам нужно найти тот единственный, который относится именно к cd. Обратите внимание, что strace выдаёт результат своей работы в поток stderr, а не в stdout.    

О как оно не легко то казалось,  но оказалось проще чем казалось.  
Сначала делаем:  
strace -o strace_output.txt /bin/bash -c 'cd /tmp'    
Все пишется в strace_output.txt. Потом :  
cat strace_output.txt | grep chdir  
в файле записаном ищем имя системного вызова для смены директории(chdir), получаем:  
chdir("/tmp")= 0  

## 2. Попробуйте использовать команду file на объекты разных типов на файловой системе. Например:  

vagrant@netology1:~$ file /dev/tty  
/dev/tty: character special (5/0)  
vagrant@netology1:~$ file /dev/sda  
/dev/sda: block special (8/0)  
vagrant@netology1:~$ file /bin/bash  
/bin/bash: ELF 64-bit LSB shared object, x86-64  
 
### Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.    
 
strace -o strace_tty.txt file /dev/tty  
strace -o strace_sda.txt file /dev/sda  
strace -o strace_bash.txt file /bin/bash  
Потом ищем open:  
cat strace_***.txt | grep open  
В выводе нам всречается (для bash):  
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libmagic.so.1", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/liblzma.so.5", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libbz2.so.1.0", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libpthread.so.0", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)  
openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3  
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3  
openat(AT_FDCWD, "/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 3  
openat(AT_FDCWD, "/bin/bash", O_RDONLY|O_NONBLOCK) = 3  

гуглим кто куда, понимаем,  что нам интерестны строки связанные с "магией". В мануале (man magic) это подтверждается прям в строке 9-10(раздел DESCRIPTION). Таким обрзом строка :   
openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3   
Ну и мануал говорит о том, что искомый файл лежит по адресу /usr/share/misc/magic.mgc   
Кроме того у нас ищются подобные файлы и в окружении:   
openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)   
openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3   


## 3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).  

Насколько понял то пока файл/дескриптор файла задействован хоть одним процессом то файл не удаляется фактически, а удаляется посути та ссылка/узел но которой файл виден и по которой обращаются процессы . При этом , как я понял можно открыть дескрипор файла и работать с ним как с не удаленным. Соответственно можно найти у того процесса, который открыл удаленый файл , дескриптор удаленого файла. А потом по сделать неренаправление в этот  дескриптор.  

echo '' >/proc/<pidнашегопроцесса>/fd/<номер дескриптора>  

Однако, смоделировать ситуацию у меня не получилось(можете подсказать как это сделать).  При удалении файла я не смог найти через:    
lsof -p <pid> | grep deleted   
файл помеченый как удаленный.  

## 4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?    

Нет "зомби" не потребляют ресурсы в ОС , это процессы которые завершились и остались лишь как запись в таблице, но их родительский процесс не послал сигнал на их закрытие. Однако не стоит путать "зомби" и "сироту". Сирота является активным процессом , который потребляет ресурсы ОС, но не имеер родителя( например отсоединен от родительского терминала).   

## 5. В iovisor BCC есть утилита opensnoop:  

root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop  
/usr/sbin/opensnoop-bpfcc  

### На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04.   

Судя по всему нужно показать, что делается за 1ю секунду трасировки:  

vagrant@vagrant:/vagrant$ sudo opensnoop-bpfcc -Td 1   
TIME(s)       PID    COMM               FD ERR PATH   
0.000000000   600    irqbalance          6   0 /proc/interrupts   
0.000086000   600    irqbalance          6   0 /proc/stat   
0.000119000   600    irqbalance          6   0 /proc/irq/20/smp_affinity   
0.000134000   600    irqbalance          6   0 /proc/irq/0/smp_affinity   
0.000144000   600    irqbalance          6   0 /proc/irq/1/smp_affinity   
0.000155000   600    irqbalance          6   0 /proc/irq/8/smp_affinity   
0.000165000   600    irqbalance          6   0 /proc/irq/12/smp_affinity   
0.000175000   600    irqbalance          6   0 /proc/irq/14/smp_affinity   
0.000185000   600    irqbalance          6   0 /proc/irq/15/smp_affinity   

sudo opensnoop-bpfcc -Td 1  
где -T включает столбик временых меток;  
    -d 1 позволяет ограничить время отслеживания в секундах , у меня стоит 1 секунда.   

## 6. Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.   

Цитата:  
 Part of the utsname information is also accessible via  
/proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.  


## 7. Чем отличается последовательность команд через ; и через && в bash? Например:  

root@netology1:~# test -d /tmp/some_dir; echo Hi  
Hi  
root@netology1:~# test -d /tmp/some_dir && echo Hi  
root@netology1:~#  

&& имеет смысл И (условный оператор), т.е. команда1 && команда2 выполняется с лева направо. Таким образом когда команда1 вернет стратус заверщения = 0, тогда и начнет выполняться команда2.(man bash строка 234).  

; имеет разделителя команд, они выполняются последовательно, но не зависимо от результата других команд в последовательности.(man bash строки 207-219).   

### Есть ли смысл использовать в bash &&, если применить set -e?  
set -e оболочка завершает сеанс при сбое команды,  
У меня закрылось подключение при попытке сделать это :  
strace set -e  
Вывело:  
strace: Can't stat 'set': No such file or directory  
Connection to 127.0.0.1 closed.  

Судя по всему && нету смысла применять с set -e, т.к. выполнение команд в случае ошибки прекратится.  

## 8. Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?   

set -euxo pipefail   
-e - прерывает выполнение скрипта если команда завершилась ошибкой, выводит в stderr строку с ошибкой;   
-u - прекращает выполнение скрипта, если встретилась несуществующая переменная;     
-x - выводит выполняемые команды в stdout перед выполненинем;   
-o pipefail - прекращает выполнение скрипта, при первой ошибке в последовательности, как я понял именно pipefail позволяет не выполнять весь пайп при первой же ошибке в нем.   

## 9. Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).  

Мой вывод:  
vagrant@vagrant:~$ ps -o stat  
STAT  
Ss  
R+  

по man ps(строка 425-446):   
Ss:  
S прерываемый сон (ожидание завершения события);   
s является лидером сеанса;   
R+:   
R работает или запускается (в очереди выполнения);   
+  находится в группе процессов переднего плана;   
Дополнительные симполы являются обозначением приоритера или дополнительных характеристик.  







