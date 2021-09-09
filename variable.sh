#!/bin/bash
## All the variable and learning

COURSE=DevOps

#Naming my course name

echo course name =$COURSE

# list of  students
 echo List of students

 # we writing new variable method

 DATE=$(date +%F)
 echo Good Morning, Today date is $DATE


NAME=HAMEEDUDDIN

echo myself $NAME

 # Author : Momin
 echo -n "Enter your DOB [ddmmyyyy] : "
 read n
 d=`echo $n | cut -c1-2`
 m=`echo $n | cut -c3-4`
 y=`echo $n | cut -c5-8`
 yy=`date "+%Y"`
 mm=`date "+%m"`
 dd=`date "+%d"`
 if [ $y -le $yy ]
 then
 yyy=`expr $yy - $y`
 mmm=`expr $mm - $m`
 #ddd=`expr $dd - $d`
 if [ $m -gt $mm ]
 then
 yyy=`expr $yyy - 1`
 mmm=`expr $mmm + 12`
 fi
 if [ $d -gt $dd ]
 then
 ddd=`expr $d - $dd`
 ddd=`expr 31 - $ddd`
 else
 ddd=`expr $dd - $d`
 fi
 fi
 echo "Your age : $yyy years $mmm months $ddd days"


 echo -e"\1m35mHAMEEDUDDIN \1m32m miss u \0m"