#!/bin/bash
## read -p it is the input which is given by user while excution

read -p 'Enter username : ' username

if [ "$username" == "root" ] ; then
  echo -e "hey user is $username is a 'Hameed the king' "
else
  echo -e "hey user is $username is normal "
fi