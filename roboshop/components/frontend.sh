#!/bin/bash

source components/common.sh
rm -f &>>/tmp/roboshop.log

HEAD "Installing Nginx \t"
yum install nginx -y  &>>/tmp/roboshop.log

STAT $?

HEAD "Start Nginx \t\t"
systemctl start nginx
systemctl enable nginx
STAT $?

HEAD "Downloading \t\t"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Deleting old HTML Docs"
rm -rf /usr/share/nginx/html/*
STAT $?

HEAD "Extracting file \t"
unzip -d /usr/share/nginx/html /tmp/frontend.zip &>>/tmp/roboshop.log
STAT $?


