FROM gliderlabs/alpine:3.4

ENV NODE_VERSION=v6.2.1 \
    NPM_VERSION=3 \
    NODE_HOME=/usr/local

RUN \
  echo "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAkLEXd3P3MFJqXXEUVvbm\n5YyrHluoRtyIVPMCTqMmBNdIi43EaYKZke8xJrBnLRyDIo/ZIF3XCMOOHL5VHsg9\n7ztIsTCK5LQRwnwKBMKpUAZvImZ4YXza2esuASBTTvL98VaVDv1UCRI+53t22TIu\nx3HYp2RWXzW0VuWjYNn5gjZJslxIFCNebspYCtaEngN4T8cGCYj5xHdGV4Xazqdy\nSRpVES99hcI6EohBU9VD3kkbD9tT+psCogJNwYDcBYngyp8oYbPhcXV1Cqwt2z96\n4RFSt4D2eIjx9sy7F+Xji7sdR7GhcRvjbwkf5Pf0gjWSdnrqlE6znCJdbk0sx1bx\nOQIDAQAB\n-----END PUBLIC KEY-----\n" > /etc/apk/keys/will.jordan@gmail.com-56bf67f5.rsa.pub \
  && apk add --no-cache --update --virtual .node-buildDeps \
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
    openssh \
  && curl -sSL https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz | tar -xz \
  && cd /node-${NODE_VERSION} \
  && ./configure --prefix=${NODE_HOME} ${CONFIG_FLAGS} \
  && make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
  && make install \
  && paxctl -cm ${NODE_HOME}/bin/node \
  && cd / \
  && if [ -x ${NODE_HOME}/bin/npm ]; then \
    npm install -g npm@${NPM_VERSION} && \
    find ${NODE_HOME}/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf; \
  fi \
  && runDeps="$( \
    scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
  )" \
  && apk add --virtual .rundeps $runDeps \
    openssh \
    git \
    g++ \
    make \
  && apk del .node-buildDeps \
  && rm -rf /node-${NODE_VERSION} \
    ${NODE_HOME}/share/man /tmp/* /root/.npm /root/.node-gyp \
    ${NODE_HOME}/lib/node_modules/npm/man ${NODE_HOME}/lib/node_modules/npm/doc ${NODE_HOME}/lib/node_modules/npm/html \
  && adduser -S node \
  && apk add libvips-dev --no-cache --update --repository https://s3.amazonaws.com/wjordan-apk

CMD [ "npm", "start" ]
