#!/bin/bash

source components/common.sh
rm -f &>>/tmp/robosho.log

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
systemctl enable mongod &>>/tmp/robosho.log
systemctl start mongod &>>/tmp/robosho.log
STAT $?