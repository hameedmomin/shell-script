help:
	@echo @fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

frontend:
	@sh components/frontend.sh

catalogue:
	@sh components/catalouge.sh

cart:
	@sh components/cart.sh

redis:
	@sh components/redis.sh

rabitmq:
	@sh components/rabitmq.sh

mysql:
	@sh components/mysql.sh

shipping:
	@sh components/shipping.sh

user:
	@sh components/user.sh

payment:
	@sh components/payment.sh

mongod:
	@sh components/mongodn.sh

