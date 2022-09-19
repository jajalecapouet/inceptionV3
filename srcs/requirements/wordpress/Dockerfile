FROM debian:buster

RUN apt-get update && apt-get install -y wget \
			php \
			php-cgi \
			php-mysql \
			php-fpm \
			php-pdo \
			php-gd \
			php-cli \
			php-mbstring \
			net-tools lsof

COPY	./www.conf /etc/php/7.3/fpm/pool.d
RUN		mkdir /run/php
WORKDIR /var/www
COPY	./init.sh /var/www/init.sh

RUN 	chmod 777 /var/www/init.sh

EXPOSE 9000

CMD	/var/www/init.sh