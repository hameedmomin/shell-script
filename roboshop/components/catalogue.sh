#!/bin/bash

source components/common.sh
rm -f tmp/robosho.log

HEAD "Installing Nodejs"
yum install nodejs make css-c++ -y &>>/tmp/roboshop.log

STAT $?

HEAD "Adding User \t"
id roboshop &>>/tmp/roboshop.log

if [ $? -eq  0 ] ; then
  echo User already exist &>>/tmp/roboshop.log
  STAT $?
else
  useradd  roboshop &>>/tmp/roboshop.log
fi

HEAD "Download from GITHUB"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Extracting Flies \t"
cd /home/roboshop &>>/tmp/roboshop.log rm -f catalogue && unzip /tmp/catalogue.zip &>>/tmp/roboshop.log && mv catalogue-main catalogue &>>/tmp/roboshop.log
STAT $?

HEAD "Installing Nodejs Files "
cd /home/roboshop/catalogue && npm install  --unsafe-perm &>>/tmp/roboshop.log
STAT $?
