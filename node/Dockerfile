FROM alpine:edge

LABEL vendor=makeomatic \
      version_tags="[\"9\",\"9.3\",\"9.3.0\"]"

ENV NODE_VERSION=v9.3.0 \
    NODE_HOME=/usr/local \
    YARN_VERSION=1.3.2-r0

RUN \
  apk upgrade --no-cache \
  && apk add --no-cache --virtual .node-buildDeps \
    git \
    curl \
    make \
    gcc \
    g++ \
    binutils-gold \
    python \
    linux-headers \
    paxctl \
    libgcc \
    libstdc++ \
  && curl -sSL https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz | tar -xz \
  && cd /node-${NODE_VERSION} \
  && ./configure --prefix=${NODE_HOME} ${CONFIG_FLAGS} \
  && make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
  && make install \
  && paxctl -cm ${NODE_HOME}/bin/node \
  && cd / \
  && runDeps="$( \
    scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
  )" \
  && apk --no-cache add yarn=${YARN_VERSION} \
  && apk --no-cache add --virtual .rundeps $runDeps \
  && apk del .node-buildDeps \
  && rm -rf /node-${NODE_VERSION} \
    ${NODE_HOME}/share/man /tmp/* /root/.npm /root/.node-gyp \
    ${NODE_HOME}/lib/node_modules/npm/man ${NODE_HOME}/lib/node_modules/npm/doc ${NODE_HOME}/lib/node_modules/npm/html \
  && adduser -S node

CMD [ "npm", "start" ]
