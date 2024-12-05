#! /bin/bash


#mkfs -t ext4 /dev/sda |grep UUID| awk '{print$3}'
lsblk -o  name,type |grep part
echo "Выбери диск /dev/:"

read disctype

echo "
Выбери  тип файловой системы
ext4
ext3
ext2
xfs
Тип файловой системы:
"

read fstype
echo

#partuuid=$(lsblk -o   name,partuuid  /dev/sdb1|awk '{print$2}' |tail -n 1)

mkfs -t $fstype /dev/$disctype

mount /dev/$disctype /storage

partuuid=$(lsblk -o   name,partuuid  /dev/$disctype|awk '{print$2}' |tail -n 1)

cat<<EOF>> /etc/fstab 
#PARTUUID=$partuuid  /storage  $fstype defaults  0  2
EOF


 
echo  "
Внимание!
В целях безопасности изменения /etc/fstab закомментированы
Необходимо перепроверить содержание файла  /etc/fstab
Если диск был приммонтирован ранее ,и у него изменились  какие -либо значения
необходимо закомментировать  строчку со старым значением и разкомментировать последнюю.
После выполнить команду
systemctl daemon-reload"

