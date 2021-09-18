#!/bin/bash
## read -p it is the input which is given by user while excution

read -p 'Enter username : ' username

if [ "$username" == "root" ] ; then
  echo -e "User is a Admin"
else
  echo -e "User is normal user"