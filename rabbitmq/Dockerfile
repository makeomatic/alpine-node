FROM janeczku/alpine-kubernetes:3.3

# Version of RabbitMQ to install
ENV RABBITMQ_VERSION=3.5.7 \
    PLUGIN_BASE=v3.5.x \
    DELAYED_MESSAGE_VERSION=0.0.1-rmq3.5.x-9bf265e4 \
    TOP_VERSION=3.5.x-99ed877e \
    AUTOCLUSTER_VERSION=0.4.1

RUN \
  apk --no-cache add coreutils curl erlang erlang-asn1 erlang-crypto erlang-eldap erlang-erts erlang-inets erlang-mnesia erlang-os-mon erlang-public-key erlang-sasl erlang-ssl erlang-xmerl erlang-hipe && \
  curl -sL -o /tmp/rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.gz https://www.rabbitmq.com/releases/rabbitmq-server/v${RABBITMQ_VERSION}/rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.gz && \
  mkdir -p /usr/lib/rabbitmq/lib /usr/lib/rabbitmq/etc && \
  cd /usr/lib/rabbitmq/lib && \
  tar xvfz /tmp/rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.gz && \
  rm /tmp/rabbitmq-server-generic-unix-${RABBITMQ_VERSION}.tar.gz && \
  ln -s /usr/lib/rabbitmq/lib/rabbitmq_server-${RABBITMQ_VERSION}/sbin /usr/lib/rabbitmq/bin && \
  ln -s /usr/lib/rabbitmq/lib/rabbitmq_server-${RABBITMQ_VERSION}/plugins /usr/lib/rabbitmq/plugins && \
  curl -sL -o /usr/lib/rabbitmq/plugins/rabbitmq_delayed_message_exchange-${DELAYED_MESSAGE_VERSION}.ez  http://www.rabbitmq.com/community-plugins/${PLUGIN_BASE}/rabbitmq_delayed_message_exchange-${DELAYED_MESSAGE_VERSION}.ez && \
  curl -sL -o /usr/lib/rabbitmq/plugins/rabbitmq_top-${TOP_VERSION}.ez http://www.rabbitmq.com/community-plugins/${PLUGIN_BASE}/rabbitmq_top-${TOP_VERSION}.ez && \
  curl -sL -o /usr/lib/rabbitmq/plugins/autocluster-${AUTOCLUSTER_VERSION}.ez https://github.com/aweber/rabbitmq-autocluster/releases/download/${AUTOCLUSTER_VERSION}/autocluster-${AUTOCLUSTER_VERSION}.ez && \
  adduser -s /bin/sh -D -h /var/lib/rabbitmq rabbitmq

# Environment variables required to run
ENV ERL_EPMD_PORT=4369 \
    HOME=/var/lib/rabbitmq \
    PATH=/usr/lib/rabbitmq/bin:$PATH \
    RABBITMQ_LOGS=- \
    RABBITMQ_SASL_LOGS=- \
    RABBITMQ_DIST_PORT=25672 \
    RABBITMQ_SERVER_ERL_ARGS="+K true +A128 +P 1048576 -kernel inet_default_connect_options [{nodelay,true}]" \
    RABBITMQ_CONFIG_FILE=/usr/lib/rabbitmq/etc/rabbitmq/rabbitmq \
    RABBITMQ_ENABLED_PLUGINS_FILE=/usr/lib/rabbitmq/etc/rabbitmq/enabled_plugins \
    RABBITMQ_MNESIA_DIR=/var/lib/rabbitmq/mnesia \
    RABBITMQ_PID_FILE=/var/lib/rabbitmq/rabbitmq.pid

COPY root/ /

# Fetch the external plugins and setup RabbitMQ
RUN \
  apk del curl && \
  ln -sf /var/lib/rabbitmq/.erlang.cookie /root/ && \
  chown rabbitmq /var/lib/rabbitmq/.erlang.cookie && \
  chmod 0600 /var/lib/rabbitmq/.erlang.cookie /root/.erlang.cookie && \
  ls -al /usr/lib/rabbitmq/plugins/ && \
  rabbitmq-plugins list && \
  rabbitmq-plugins enable --offline \
        rabbitmq_delayed_message_exchange \
        rabbitmq_management \
        rabbitmq_management_visualiser \
        rabbitmq_consistent_hash_exchange \
        rabbitmq_federation \
        rabbitmq_federation_management \
        rabbitmq_mqtt \
        rabbitmq_shovel \
        rabbitmq_shovel_management \
        rabbitmq_stomp \
        rabbitmq_top \
        rabbitmq_web_stomp \
        autocluster && \
  chown -R rabbitmq /usr/lib/rabbitmq /var/lib/rabbitmq

VOLUME ["/var/lib/rabbitmq","/usr/lib/rabbitmq/etc/rabbitmq"]

EXPOSE 4369 5671 5672 15672 25672
