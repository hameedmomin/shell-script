#!/bin/bash

echo -n "Installing Nginx ..."
yum install nginx -y &>>/tmp/roboshop.log
echo -e "\e[32mDone\e[0m hello"
