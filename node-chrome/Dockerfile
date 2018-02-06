FROM makeomatic/node:9.5.0

RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --no-cache --upgrade chromium grep udev ttf-opensans

ENV LIGHTHOUSE_CHROMIUM_PATH=/usr/bin/chromium-browser
