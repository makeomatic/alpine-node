FROM redis/redis-stack-server

RUN \
  apt-get update \
  && apt-get install -y -q \
    supervisor \
    tcl \
  	gettext \
    iproute2 \
  && mkdir /redis-conf \
  && mkdir /redis-data

COPY ./docker-data/redis-cluster.tmpl /redis-conf/redis-cluster.tmpl
COPY ./docker-data/redis.tmpl /redis-conf/redis.tmpl

# Add supervisord configuration
COPY ./docker-data/supervisord.conf /etc/supervisor/supervisord.conf

# Add startup script
COPY ./docker-data/docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 7000 7001 7002 7003 7004 7005

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["redis-cluster"]
