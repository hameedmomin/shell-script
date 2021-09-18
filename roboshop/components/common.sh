HEAD() {
    echo -n -e "\e[1m $1 \e[0m \t\t ..."
}
STAT() {
  if [ $1 eq 0 ]; then
    echo -e "\e[1;32mDone\e[0m"
  else
    echo -e "\e[1;31mFail\e[0m"
    echo -e "\t\e[1;33m Check log file for details ... LOG FIle: &>>/tmp/roboshop.log e\[0m"
    exit 1

  fi
}