#!/bin/bash

source components/common.sh

HEAD "Installing Nginx ..."
yum install nginx -y &>>/tmp/null
STAT $1
