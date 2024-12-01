#! /bin/bash
PROC=procinfo
DISK=diskinfo
SMART=smartinfo
RAM=raminfo
NET=networkinfo
INFODIR=$NEWDIR/infodir
#

#
NEWDIR=$HOME/storage/pw2
FILE1=$HOME/storage/pw2/file1
FILE2=$HOME/storage/pw2/file2
FILE3=$HOME/storage/pw2/file3
FILE4=$HOME/storage/pw2/file4
FILE5=$HOME/storage/pw2/file5
FILE6=$HOME/storage/pw2/file6
FILE7=$HOME/storage/pw2/file7
#1

mkdir -p $HOME/storage/pw2
#24


#2,3

echo "Hello World!" > $NEWDIR/file1  && date > $NEWDIR/file2

#4

users >> $FILE1
#5
for (( i=1; i <= 3; i++ ))
do
echo "Hello world!" >> $FILE2
done

#6

cat $FILE1 >> $FILE2

#7

cat $FILE1 $FILE2 > $FILE3

#8

mv $FILE1 $NEWDIR/newfile1

#9

for ((i=1; i <= 3; i++ ))
do 

ls $NEWDIR  >> $FILE4

done
#10,11

cat $FILE4 && cat $FILE4 > $FILE5  && wc -l < $FILE5

#12,13

mkdir -p $NEWDIR/dir1 && mv $FILE5 $NEWDIR/dir1

#14

ln -s $FILE4 file4

#15
mkdir -p $NEWDIR/dir2  && cp  $NEWDIR/dir1/*file* $NEWDIR/dir2

#16
ls $PWD |wc -w

#17 

touch $FILE5

#18

uname -a  &&  uname -a > $FILE6

#19 20 21
mkdir -p $NEWDIR/mydir &&  touch $NEWDIR/mydir/file7 && rm -rf $NEWDIR/mydir/

#22
tail -n 2 $FILE2

#23

PROC=procinfo
DISK=diskinfo
SMART=smartinfo
RAM=raminfo
NET=networkinfo
INFODIR=$NEWDIR/infodir

#24

mkdir  $INFODIR

#25 
ps aux && ps  aux > $INFODIR/$PROC
#26
lsblk -o name,size,mountpoint && lsblk -o name,size,mountpoint > $INFODIR/$DISK
#27
DISKSSUMMARY=$(lsblk |grep disk |wc -l)

if [ $DISKSSUMMARY -gt 1 ]; then
echo "You have more than one disc.
Please choose disc  
$(lsblk -o name,type |grep disk)
DISC:"

read CHOOSENDISC

sudo smartctl -i /dev/$CHOOSENDISC && sudo smartctl -i /dev/$CHOOSENDISC > $INFODIR/$SMART

else

sudo smartctl -i /dev/$(lsblk |grep disk |awk '{print $1}')

fi

#28
free -h && free -h > $INFODIR/$RAM

#29

ip -c -br a && ip -c -br a > $INFODIR/$RAM


