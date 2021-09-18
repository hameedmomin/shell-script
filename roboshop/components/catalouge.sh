#!/bin/bash

source components/common.sh

HEAD "Installing Nodejs"
yum install nodejs make css-c++ -y &>>/tmp/roboshop.log

STAT $?