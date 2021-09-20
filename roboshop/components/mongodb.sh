#!/bin/bash

source components/common.sh
rm -f tmp/robosho.log

HEAD "Setting up Repo files \t"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
STAT $?

HEAD "Installing MongoDB service"
yum install -y mongodb-org &>>/tmp/robosho.log
STAT $?


HEAD "Updating IP address \t\t"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
STAT $?

HEAD "Starting MongoDB \t\t"
systemctl enable mongod &>>/tmp/robosho.log
systemctl restart mongod &>>/tmp/robosho.log

STAT $?

HEAD "Downloading Schema \t\t"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
STAT $?

HEAD "Extract Downloaded Files"
cd /tmp
unzip -o mongodb.zip &>>/tmp/robosho.log

STAT $?

HEAD "Loading Schema \t\t"
cd mongodb-main

mongo < catalogue.js &>>/tmp/robosho.log && mongo < users.js &>>/tmp/robosho.log

STAT $?


