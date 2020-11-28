FROM alpine:edge
MAINTAINER Luc Michalski <lmichalski@evolutive-business.com>

ARG MARIABD_VERSION=${MARIABD_VERSION:-"10.5.6-r0"}

RUN apk --no-cache --no-progress add mariadb==${MARIABD_VERSION} mariadb-client mariadb-connector-c certbot openssl logrotate

COPY mariadb-server.cnf /opt/mariadb-server.cnf
COPY certbot-renew.sh /opt/certbot-renew.sh
COPY entrypoint.sh /opt/entrypoint.sh
COPY logrotate.conf /opt/logrotate.conf

RUN chmod +x /opt/*.sh

VOLUME /var/lib/mysql
VOLUME /etc/letsencrypt
VOLUME /custom.cnf.d
VOLUME /custom.sql.d

EXPOSE 80
EXPOSE 3306

ENTRYPOINT ["/opt/entrypoint.sh"]
