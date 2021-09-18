#!/bin/bash

source components/common.sh

HEAD -n "Installing Nginx ..."
yum install nginx
echo -e "\e[32mDone\e[0m"
