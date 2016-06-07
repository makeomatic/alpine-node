FROM makeomatic/alpine-node:$NODE_VER

ONBUILD ARG WORKDIR=/src
ONBUILD WORKDIR $WORKDIR
ONBUILD USER node
ONBUILD COPY ./package.json /src/package.json
ONBUILD ARG NODE_ENV=production
ONBUILD RUN npm install && npm dedupe
ONBUILD COPY . /src
ONBUILD USER root
ONBUILD RUN apk del git curl make gcc g++ python && \
  rm -rf /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp src /etc/ssl
ONBUILD USER node
