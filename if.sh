#!/bin/bash
## read -p it is the input which is given by user while excution

read -p 'Enter username : '

if [ "$username" == "root" ] ; then
  echo -e "hey user is $username is a 'Hameed the king' "
else
  echo -e "hey user is $username is normal "
fi

read -p 'File exist :'

if [ -f "$filename" ] ; then

  echo "file exist"
else
  echo "file doesnot exist"
fi