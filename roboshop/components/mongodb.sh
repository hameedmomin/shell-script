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

HEAD "Starting MongoDB"
systemctl enable mongod &>>/tmp/robosho.log
systemctl start mongod &>>/tmp/robosho.log
STAT $?

HEAD "Updating IP address"
sed -i -e 'c/127.0.0.1/0.0.0.0' /etc/mongod.conf
STAT $?

HEAD "Starting MongoDB"
systemctl enable mongod &>>/tmp/robosho.log
systemctl restart mongod &>>/tmp/robosho.log
STAT $?

HEAD "Downloading Schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
cd /tmp
STAT $?

HEAD "Uzipping files"
unzip mongodb.zip &>>/tmp/robosho.log
cd mongodb-main
STAT $?

HEAD "Remaining file"
mongo < catalogue.js && mongo < users.js
STAT &?
