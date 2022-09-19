FROM alpine:3.15

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils net-tools lsof && \
	rm -f /var/cache/apk/*

RUN	mkdir scripts

ADD 	./run.sh /scripts/run.sh

COPY	./50-server.cnf /usr/share/mysql/50-server.cnf

RUN	mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT ["/scripts/run.sh"]