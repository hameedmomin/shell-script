#!/bin/bash

source components/common.sh

echo "Installing Nodejs"
yum install nodejs make css-c++ -y &>>/tmp/roboshop.log

STAT $?