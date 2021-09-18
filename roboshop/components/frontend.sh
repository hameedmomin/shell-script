#!/bin/bash

source components/common.sh

HEAD "Installing Nginx"
yum install nginx -y  &>>/tmp/roboshop.log

STAT $1

