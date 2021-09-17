help:	##Print Help Messages
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

frontend:	##Install Frontend component
	@sh components/frontend.sh

catalogue:	##Install Catalogue component
	@sh components/catalouge.sh

cart:	##Install Cart component
	@sh components/cart.sh

redis:	##Install Redis component
	@sh components/redis.sh

rabitmq:	##Install Rabitmq component
	@sh components/rabitmq.sh

mysql:	##Install MySQL component
	@sh components/mysql.sh

shipping:	##Install Shipping component
	@sh components/shipping.sh

user:	##Install User component
	@sh components/user.sh

payment:	##Install Payment component
	@sh components/payment.sh

mongod:	##Install MongoDB component
	@sh components/mongodn.sh

