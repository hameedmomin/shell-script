#!/bin/bash

source components/common.sh
rm -f tmp/roboshop.log
HEAD "Setup MYSQL service"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
STAT $?

HEAD "Install MySQL Server"
yum remove mariadb-libs -y &>>/tmp/roboshop.log && yum install mysql-community-server -y &>>/tmp/roboshop.log
STAT $?

HEAD "Start MySQL Service"
systemctl enable mysqld &>>/tmp/roboshop.log && systemctl start mysqld &>>/tmp/roboshop.log
STAT $?