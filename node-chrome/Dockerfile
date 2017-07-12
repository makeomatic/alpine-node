FROM makeomatic/node:8.1.4

RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --no-cache --upgrade chromium grep udev ttf-opensans

ENV LIGHTHOUSE_CHROMIUM_PATH=/usr/bin/chromium-browser
