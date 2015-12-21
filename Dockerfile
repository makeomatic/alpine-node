FROM alpine:3.2

ARG VERSION=v5.1.0
ARG NPM_VERSION=3

RUN apk add --update git curl make gcc g++ binutils-gold python linux-headers paxctl libgcc libstdc++ && \
  curl -sSL https://nodejs.org/dist/${VERSION}/node-${VERSION}.tar.gz | tar -xz && \
  cd /node-${VERSION} && \
  ./configure --prefix=/usr ${CONFIG_FLAGS} && \
  make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  make install && \
  paxctl -cm /usr/bin/node && \
  cd / && \
  if [ -x /usr/bin/npm ]; then \
    npm install -g npm@${NPM_VERSION} && \
    find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf; \
  fi && \
  apk del linux-headers paxctl && \
  rm -rf /etc/ssl /node-${VERSION} \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

ONBUILD ARG WORKDIR=/src
ONBUILD WORKDIR $WORKDIR
ONBUILD COPY ./package.json /src/package.json
ONBUILD ARG NODE_ENV=production
ONBUILD ARG NPM_PROXY=https://registry.npmjs.com
ONBUILD RUN npm install --registry=$NPM_PROXY
ONBUILD RUN apk del git curl make gcc g++ python && \
  rm -rf /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp src
ONBUILD COPY . /src

CMD [ "npm", "start" ]
