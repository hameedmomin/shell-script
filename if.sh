#!/bin/bash
## read -p it is the input which is given by user while excution

read -p 'Enter username : ' username

if [ username == root] ; then
  else -e "Not a Root user"