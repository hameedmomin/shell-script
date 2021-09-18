HEAD() {
  echo -n -e "\[1m $1 \e[0m \t\t ..."
}
STAT() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[1;32mDone"
  else
    echo -e"\e[1;31mFail"
  fi

}