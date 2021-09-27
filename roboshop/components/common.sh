HEAD() {
    echo -n -e "\e[1m $1 \e[0m \t\t ..."
}
STAT() {
  if [ $1 -eq 0 ] ; then
    echo -e "\e[1;32mDone\e[0m"
  else
    echo -e "\e[1;31mFail\e[0m"
    echo -e "\t\e[1;33m Check log file for details ... LOG FIle:/tmp/roboshop.log \e[0m"
    exit 1
  fi
}

USER_ADD() {
  HEAD "Adding User \t"
  id roboshop &>>/tmp/roboshop.log
  if [ $? -eq  0 ]; then
    echo User already exist &>>/tmp/roboshop.log
    STAT $?
  else
    useradd  roboshop &>>/tmp/roboshop.log
    STAT $?
  fi
}
SETUP_SYSTEMD() {
  HEAD "Setup sysytemD Service"
  sed -i -e 's/MONGO_DNSNAME/mongodb.connection.internal/' -e 's/REDIS_ENDPOINT/redis.connection.internal/' -e 's/MONGO_ENDPOINT/mongodb.connection.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.connection.internal/'  /home/roboshop/$1/systemd.service && mv /home/roboshop/$1/systemd.service /etc/systemd/system/$1.service
  STAT $?

  HEAD "Start $1 service"
  systemctl daemon-reload && systemctl enable $1 &>>/tmp/roboshop.log && systemctl restart $1 &>>/tmp/roboshop.log
  STAT $?
}

NODEJS() {
  HEAD "Installing Nodejs"
  yum install nodejs make css-c++ -y &>>/tmp/roboshop.log

  STAT $?

  USER_ADD
  DOWNLOAD_FROM_GITHUB $1

  HEAD "Installing Nodejs Files "
  cd /home/roboshop/$1 && npm install  --unsafe-perm &>>/tmp/roboshop.log
  STAT $?

  FIX_APP_CONENT_PERM

  SETUP_SYSTEMD "$1"
}

DOWNLOAD_FROM_GITHUB() {
  HEAD "Download App from GitHub\t"
  curl -s -L -o /tmp/$1.zip "https://github.com/roboshop-devops-project/$1/archive/main.zip" &>>/tmp/roboshop.log
  STAT $?

  HEAD "Extract the Downloaded Archive"
  cd /home/roboshop && rm -rf $1 && unzip /tmp/$1.zip &>>/tmp/roboshop.log && mv $1-main $1
  STAT $?
}

FIX_APP_CONENT_PERM() {
  HEAD "Fix Permissions to App Content"
  chown roboshop:roboshop /home/roboshop -R
  STAT $?
}

MAVEN() {
  HEAD "Install Maven"
  yum install maven -y &>>/tmp/roboshop.log
  STAT $?

  USER_ADD
  DOWNLOAD_FROM_GITHUB $1

  HEAD "Make Application Package"
  cd /home/roboshop/$1 && mvn clean package &>> /tmp/roboshop.log && mv target/$1-1.0.jar $1.jar  &>>/tmp/roboshop.log
  STAT $?

  FIX_APP_CONENT_PERM

  SETUP_SYSTEMD "$1"
}