#!/bin/bash

source components/common.sh
rm -f tmp/robosho.log

HEAD "Installing Nodejs"
yum install nodejs make css-c++ -y &>>/tmp/roboshop.log

STAT $?

HEAD "Adding User \t"
useradd roboshop &>>/tmp/roboshop.log
STAT $?

HEAD "Download from GITHUB"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Extracting Flies \t"
cd /home/roboshop &>>/tmp/roboshop.log && unzip /tmp/catalogue.zip &>>/tmp/roboshop.log && mv catalogue-main catalogue &>>/tmp/roboshop.log
STAT $?

HEAD "Installing Nodejs Files "