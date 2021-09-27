#!/bin/bash

source components/common.sh
rm -f tmp/robosho.log


HEAD "Setup repo "
yum install epel-release yum-utils install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>/tmp/robosho.log && yum-config-manager --enable remi &>>/tmp/robosho.log
STAT $?

HEAD "Install Redis"
yum install redis -y &>>/tmp/robosho.log
STAT $?

HEAD "Update IP address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
STAT $?

HEAD "start Redis Service"
systemctl enable redis &>>/tmp/robosho.log && systemctl restart redis &>>/tmp/robosho.log
STAT $?
