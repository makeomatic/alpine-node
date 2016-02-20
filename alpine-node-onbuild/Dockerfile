FROM makeomatic/alpine-node:$NODE_VER

ONBUILD ARG WORKDIR=/src
ONBUILD WORKDIR $WORKDIR
ONBUILD COPY ./package.json /src/package.json
ONBUILD ARG NODE_ENV=production
ONBUILD ARG NPM_PROXY=https://registry.npmjs.com
ONBUILD RUN npm install --registry=$NPM_PROXY
ONBUILD COPY . /src
ONBUILD RUN apk del git curl make gcc g++ python && \
  rm -rf /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp src
