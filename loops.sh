#!/bin/bash

#there are two type of loops "while" and "for" loops

# Syntax
# while [ expression ] ; do
# commands
#done

i=10
while [ $i -gt 0 ]; do
  echo -n $i
  i=$(($i-1))
done

# for var in values ; do
# commands
# done

for fruit in apple banana orange ; do
  echo Fruit Name = $fruit
  sleep 1
done